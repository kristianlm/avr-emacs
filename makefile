# user modifiable secion is up here
DEVICE=atmega328p
PROGRAMMER=avrispmkII
PROGPORT=usb
TERMPORT=/dev/ttyACM0

# hopefully, you don't have to touch anything down here
VERSION=2010.06.13

SEND=sudo ./send.f $(TERMPORT)
AVRDUDE=sudo avrdude -c $(PROGRAMMER) -p $(DEVICE) -P $(PROGPORT)
GFORTH=gforth

avrforth: avrforth.f config.f asm/* drivers/*
	$(GFORTH) -e ": device s\" $(DEVICE)\" ;" -e ": version s\" $(VERSION)\" ;" avrforth.f -e "bye"

test: avrforth.f config.f asm/* drivers/*
	$(GFORTH) -e ": device s\" $(DEVICE)\" ;" -e ": version s\" $(VERSION)\" ;" avrforth.f

upload: flash eeprom
	$(AVRDUDE) -e -U flash:w:flash:r -U eeprom:w:eeprom:r

verify: flash eeprom
	$(AVRDUDE) -U flash:v:flash:r -U eeprom:v:flash:r

download:
	$(AVRDUDE) -U flash:r:/tmp/flash:r -U eeprom:r:/tmp/eeprom:r

stty:
	sudo stty -F $(TERMPORT) 38400 raw -icanon min 1 time 0 -echo -echoe -echok -icrnl

terminal:
	$(AVRDUDE) -t -u

reset:
	$(AVRDUDE)

serial:
# delbs : so that backspace works in my terminal
# lfcr : so that newline works inside emacs (C-u M-x run-forth <RET> make serial)
	picocom -l --omap delbs,lfcr -b 38400 $(TERMPORT)

highlevel: blocks/core.f blocks/assembler.f blocks/bit.f blocks/extend.f \
           blocks/flag.f blocks/lerp.f blocks/debug.f
	for block_ in $^; do $(SEND) $$block_ ; done

clean:
	rm -f flash eeprom
  
dist:
	git archive --format=tar --prefix=avrforth-$(VERSION)/ \
	$(VERSION) | gzip > /tmp/avrforth-$(VERSION).tar.gz

