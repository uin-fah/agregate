pkgname=youget
pkgver=0.0.1
pkgrel=1
pkgdesc="Youtube donwloader and formater"
arch=(x86_64)
license=(CUSTOM)
source=("youget")
sha256sums=('SKIP')



package() {
    mkdir -p $pkgdir/usr/bin
    install -D -m755 youget $pkgdir/usr/local/bin/$pkgname
}
