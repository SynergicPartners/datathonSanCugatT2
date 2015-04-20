
##Instalacion git

Windows: http://msysgit.github.io/

Debian/Ubuntu

    apt-get install git

Fedora

    yum install git

Gentoo

    emerge --ask --verbose dev-vcs/git

Arch Linux

    pacman -S git

openSUSE

    zypper install git

FreeBSD

    cd /usr/ports/devel/git
    make install

Solaris 11 Express

    pkg install developer/versioning/git

OpenBSD

    pkg_add git

##Como usar git (clone, add, commit, push, checkout)

Clonar al directorio actual y entrar en la carpeta

    git clone https://github.com/SynergicPartners/hackatonsyn.git
    cd datatonSanCugat
Añadir uno a todos los ficheros nuevos generados en local

    git add <filename>
    git add .

Hacer commit de nuestros datoa cambiados reportando el cambio con mensaje

    git commit -m "Cambio en ..."

Actualizar definitivamente los cambios a repositorio siendo target: master, <nombre del branch el cual estamos trabajando>

    git push origin <target>

Crea una nueva rama llamada "rama1" y trabajar en ella

    git checkout -b rama1

##Herramientas para desarrollar

| Herramienta |	Descripción | Descarga	| Tutorial |
|------------|--------------|-----------|----------|
| Android Studio | Entorno de desarrollo para APP Android |	http://bit.ly/1IZie9q |	http://bit.ly/1HmYsX8 |
| Eclipse |	Entorno de desarrollo |	http://bit.ly/18ub3Xx |	http://bit.ly/1H2vqM7 |
| ADT |	Plugin para crear desarrollos APP Android en Eclipse | http://bit.ly/1kakf76 |	
| R	| Herramienta estadística por consola | http://bit.ly/1aZ5k0T |
| Rstudio |	Herramienta estdística con interfaz de desarrollo |	http://bit.ly/1iywQo6 |	http://bit.ly/1aNcp3J |
| Netbeans | Entorno de desarrollo | http://bit.ly/1daNBmX | http://bit.ly/1DDhxTe |
| JqueryMobile | Entorno de desarrollo APP Mobile Multiplataforma |	http://bit.ly/1H2vlYL |	http://bit.ly/1yq94mt |
| PhoneGap | Entorno de desarrollo para APP Mobile multiplataforma |	http://bit.ly/1kASu9i |	http://bit.ly/1I9adi0 |



