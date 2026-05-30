#!/bin/bash
SPEC=$(ls ./*.spec | head -1)
NAME=$(grep '^Name:' "$SPEC"      | sed 's/Name:[[:space:]]*//')
VERSION=$(grep '^Version:' "$SPEC" | sed 's/Version:[[:space:]]*//')
RELEASE=$(grep '^Release:' "$SPEC" | sed 's/Release:[[:space:]]*//' | sed 's/%{?dist}//')
ARCH=$(grep '^BuildArch:' "$SPEC"  | sed 's/BuildArch:[[:space:]]*//')
# Fall back to host arch if BuildArch is not set in the spec
[ -z "$ARCH" ] && ARCH=$(uname -m)

TOPDIR="$PWD/rpmbuild"
BUILDROOT="$TOPDIR/BUILDROOT/$NAME-$VERSION-$RELEASE.$ARCH"
BASE="$PWD"

mkdir -p "$TOPDIR"/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p "$BUILDROOT"

##############################################################
#							     #
#							     #
#  COMPILE ANYTHING NECESSARY HERE			     #
#							     #
#							     #
##############################################################

##############################################################
#							     #
#							     #
#  REMEMBER TO DELETE SOURCE FILES FROM BUILD DIR	     #
#  BEFORE BUILD						     #
#							     #
#							     #
##############################################################

for dir in bin etc usr lib lib32 lib64 libx32 sbin var opt; do
    if [ -d "$dir" ]; then
        cp -R "$dir" "$TOPDIR/BUILD/"
    fi
done

cp "$SPEC" "$TOPDIR/SPECS/"

#build the shit
rpmbuild --define "_topdir $TOPDIR" \
         --buildroot "$BUILDROOT" \
         -bb "$TOPDIR/SPECS/$(basename "$SPEC")"

mkdir -p "$BASE/build"
find "$TOPDIR/RPMS" -name "*.rpm" -exec mv {} "$BASE/build/" \;
rm -rf "$TOPDIR"
