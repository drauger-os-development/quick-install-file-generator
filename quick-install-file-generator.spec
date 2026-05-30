Name:       quick-install-file-generator
Version:    0.1.2
# Pre-release versions use a 0. prefix so they sort below the final release.
# Strip %{?dist} when reading this field in build scripts.
Release:    0.alpha1%{?dist}
Summary:    Generate a Quick Install config file
License:    GPL-2.0-or-later
URL:        https://github.com/drauger-os-development/quick-install-file-generator
BuildArch:  noarch
Packager:   Thomas Castleman <batcastle@draugeros.org>
Requires:   python3

%description
Use your existing system settings, or create unique settings, and dump
them to a file to use with Drauger OS's Quick Install feature.

# ─── Build ────────────────────────────────────────────────────────────────────
# Compilation is handled in build-rpm.sh before rpmbuild is invoked.
# Nothing to do here.
%build

# ─── Install ──────────────────────────────────────────────────────────────────
%install
rm -rf %{buildroot}

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
#  BEFORE PACKAGING					     #
#							     #
#							     #
##############################################################

for dir in bin etc usr lib lib32 lib64 libx32 sbin var opt; do
    [ -d "%{_builddir}/$dir" ] && cp -a "%{_builddir}/$dir" "%{buildroot}/"
done

# ─── Files ────────────────────────────────────────────────────────────────────
%files
%defattr(-,root,root,-)
/*

# ─── Changelog ────────────────────────────────────────────────────────────────
%changelog
* Thu Jan 01 2026 Thomas Castleman <batcastle@draugeros.org> - 0.1.2-0.alpha1
- Initial RPM packaging
