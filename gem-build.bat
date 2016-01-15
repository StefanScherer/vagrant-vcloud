rem small helper for me to build the developer version on a windows host
set ORIG_PATH=%PATH%
set PATH=%PATH%;c:\hashicorp\vagrant\embedded\bin
gem build vagrant-vcloud.gemspec
set PATH=%ORIG_PATH%
