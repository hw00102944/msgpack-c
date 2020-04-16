$filename=''
$filepath=''
$foldername=''
$folderpath=''
$curfolder= Split-Path -Parent $MyInvocation.MyCommand.Definition
$urlpath=''
$webClint = new-object system.net.webclient
$boostfolder = $curfolder + '\boost'
$msg=''
$boostInstallPath='C:\Boost'

if (!(test-path $boostfolder)) {
    mkdir boost
}

cd boost

$versions=@('1.63.0','1.64.0','1.65.0','1.66.0','1.67.0','1.68.0','1.69.0','1.70.0','1.71.0','1.72.0')
foreach ($ver in $versions) {
    $foldername = 'boost_' + $ver.replace(".", "_")
    $folderpath = $boostfolder + '\' + $foldername
    #delete  boost source code folder if exists for unzip file
    if (test-path $folderpath) {
        rmdir $foldername -recurse
    }

    $filename = $foldername + '.zip'
    $urlpath = 'https://dl.bintray.com/boostorg/release/' + $ver + '/source/' + $filename
    $filepath = $boostfolder + '\' + $filename
    if (!(test-path $filepath)) {
        $webClint.downloadfile($urlpath, $filepath)
    }

    if (!(test-path $filepath)) {
        $msg = $msg + '\n\rDownload boost source code failed: ' + $filename
        continue
    }

    Expand-Archive -Path $filepath -DestinationPath $boostfolder

    cd $foldername
    .\bootstrap.bat
    .\b2 stage architecture=x86 address-model=64 --without-graph --without-graph_parallel --stagedir='d:\install\boost' link=static runtime-link=shared runtime-link=static threading=multi debug release
    
    #delete installed files
    if (test-path $boostInstallPath) {
        rmdir $boostInstallPath -recurse
    }

    .\b2 install
    cd ..
    cd ..
    cd msgpack-c
    if (test-path build) {
        rmdir build -recurse
    }

    mkdir build
    cd build

    cmake -A x64 -DCMAKE_TOOLCHAIN_FILE="D:/Libs/vcpkg/scripts/buildsystems/vcpkg.cmake" -DMSGPACK_CXX11=ON -DMSGPACK_BOOST=ON "-DCMAKE_CXX_FLAGS=/D_VARIADIC_MAX=10 /EHsc /D_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING" ..
    cmake  --build . --config Release
    $pathbak="$env:PATH"
    $env:PATH="D:\Libs\vcpkg\installed\x64-windows\bin;$CUR\build\Release;$pathbak"
    ctest -V
    $env:PATH = $pathbak
    cd ..
    cd ..
    cd boost

}

cd ..
Write-Output $msg