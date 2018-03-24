# user modifiable secion is up here
BAUD=9600
DEVICE=atmega328p
PROGRAMMER=avrispmkII
PROGPORT=usb
TERMPORT=/dev/ttyACM0

# hopefully, you don't have to touch anything down here
VERSION=2010.06.13

SEND=gforth ./send.f $(TERMPORT)
AVRDUDE=sudo avrdude -c $(PROGRAMMER) -p $(DEVICE) -P $(PROGPORT)
GFORTH=gforth

avrforth: avrforth.f config.f asm/* drivers/*
	$(GFORTH) -e ": device s\" $(DEVICE)\" ;" -e ": version s\" $(VERSION)\" ;" avrforth.f -e "bye"

test: avrforth.f config.f asm/* drivers/*
	$(GFORTH) -e ": device s\" $(DEVICE)\" ;" -e ": version s\" $(VERSION)\" ;" avrforth.f

upload: flash eeprom
	$(AVRDUDE) -e -U flash:w:flash:r -U eeprom:w:eeprom:r

upload-highlevel:
	$(AVRDUDE) -e -U flash:w:flash.backup:r -U eeprom:w:eeprom.backup:r

verify: flash eeprom
	$(AVRDUDE) -U flash:v:flash:r -U eeprom:v:flash:r

download:
	$(AVRDUDE) -U flash:r:flash.backup:r -U eeprom:r:eeprom.backup:r

terminal:
	$(AVRDUDE) -t -u

reset:
	$(AVRDUDE)

serial:
# delbs : so that backspace works in my terminal
# lfcr : so that newline works inside emacs (C-u M-x run-forth <RET> make serial)
	picocom -l --stopbits 2 --omap delbs,lfcr -b $(BAUD) $(TERMPORT)

repl:
# delbs : so that backspace works in my terminal
# lfcr : so that newline works inside emacs (C-u M-x run-forth <RET> make serial)
	stty -F $(TERMPORT) $(BAUD) raw -echo
	csi -s repl.scm $(TERMPORT)

highlevel: blocks/core.f blocks/assembler.f blocks/bit.f blocks/extend.f \
           blocks/flag.f blocks/lerp.f blocks/debug.f \
           blocks/pin.f blocks/miniboard.f blocks/oled.f blocks/font4x6.f
	for block_ in $^; do $(SEND) $$block_ ; done


# writing fuses can be dangerous, it can bring your chip.
___fuse:
	$(AVRDUDE) -U hfuse:w:0xD9:m -U lfuse:w:0xF2:m
        # we usually don't need to change efuse
fuse:
	$(AVRDUDE)

clean:
	rm -f flash eeprom

dist:
	git archive --format=tar --prefix=avrforth-$(VERSION)/ \
	$(VERSION) | gzip > /tmp/avrforth-$(VERSION).tar.gz

