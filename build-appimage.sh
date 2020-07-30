#!/bin/bash
# -*- coding: utf-8 -*-
#
#  build-appimage.sh
#  
#  Copyright 2020 Thomas Castleman <contact@draugeros.org>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#
PACKAGE_NAME=$(grep 'Package:' DEBIAN/control | awk '{print $2}')
DEB_NAME=$(./build-deb.sh | grep '^dpkg-deb' | awk '{print $6}')
DEB_NAME=${DEB_NAME/\'./}
DEB_NAME=${DEB_NAME/\'/}
mv "../$DEB_NAME" "$PACKAGE_NAME/"
./pkg2appimage "$PACKAGE_NAME".yml


