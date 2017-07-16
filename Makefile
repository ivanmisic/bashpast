#   Bashpast bookmarks your commands for easier invocation
#   Copyright (C) 2017 Ivan Misic
#
#   This file is part of Bashpast.
#
#   Bashpast is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   Bashpast is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with Bashpast.  If not, see <http://www.gnu.org/licenses/>.

SHELL=/bin/bash
DESTDIR=~/.local/bin

.PHONY: install clean

install:
	@echo ""
	mkdir -p $(DESTDIR)
	cp bashpast.sh $(DESTDIR)
	@echo ""
	@echo "Please update your .bashrc file with the command 'source $(DESTDIR)/bashpast.sh >> ~/.bashrc'"
	@echo ""

clean:
	rm $(DESTDIR)/bashpast.sh

