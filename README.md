# About #

This is a colletion of various ebuilds that are useful for me.

# Install #

Firstly, set `overlays` in `/etc/layman/layman.cfg`:

        overlays  : http://www.gentoo.org/proj/en/overlays/layman-global.txt
                    file:///usr/portage/local/layman/my-list.xml

Then, echo into `/usr/portage/local/layman/my-list.xml` the following:

        <?xml version="1.0"?>
        <layman>
          <overlay contact="ivan.chernetsky@nospam-gmail.com"
                   name="ichernetsky"
                   src="git://github.com/ichernetsky/gentoo-overlay.git"
                   status="unofficial"
                   type="git">
            <description>Some miscellaneous ebuilds</description>
          </overlay>
        </layman>

Of course, don't forget to remove *nospam-* from the e-mail address. Finally, do `layman -a ichernetsky` on behalf of root.

# License #

GPL v2
