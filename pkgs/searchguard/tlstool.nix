{ stdenv, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "search-guard-tlstool";
  name = "${pname}-${version}";
  version = "1.7";

  src = fetchTarball {
    url =
      "https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-tlstool/${version}/search-guard-tlstool-${version}.tar.gz";
    sha256 = "0w7xhzlykg559rzqsv40wgiwzanq01ji3hr26fd5wlklamkcrlq3";
  };

  dontBuild = true;
  buildInputs = [ makeWrapper jre ];
  runtimeDependencies = [ jre ];

  installPhase = ''
    set -x
    mkdir -p $out/bin $out/deps
    find ${src} -name '*.sh' -exec cp {} "$out"/bin \;
    find ${src} -name '*.jar' -exec cp {} "$out"/deps \;
    find "$out/bin" -name '*.sh' -executable | while read path; do
      wrapProgram "$path" --set JAVA_HOME "${jre}"
    done
  '';

  meta = with stdenv.lib; {
    description = "Daemon for controlling APC UPSes";
    homepage = "https://docs.search-guard.com/latest/offline-tls-tool";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
