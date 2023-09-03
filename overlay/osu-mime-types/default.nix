{ runCommand }:
runCommand "osu-mime-types" { } ''
  install -Dm644 ${./mimetype.xml} $out/share/mime/packages/osu.xml
''
