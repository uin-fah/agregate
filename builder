#!/bin/bash
# https://github.com/yt-dlp/yt-dlp/tree/master?tab=readme-ov-file#compile
# https://builtin.com/articles/error-externally-managed-environment
# https://stackoverflow.com/questions/990754/how-to-leave-exit-deactivate-a-python-virtualenv

if [[ -f yt-dlp_linux ]];then
    rm yt-dlp_linux
fi

python3 -m venv lib
source lib/bin/activate
cd lib
python3 devscripts/install_deps.py --include pyinstaller
python3 devscripts/make_lazy_extractors.py
python3 -m bundle.pyinstaller
deactivate
mv dist/yt-dlp_linux ../../youget
cd ..
mv yt-dlp_linux youget
makepkg -sr --sign -f &&
mv youget-0.0.1-1-x86_64.pkg.tar.zst ../blackbird/x86_64/
mv youget-0.0.1-1-x86_64.pkg.tar.zst.sig ../blackbird/x86_64/
cd ../blackbird/x86_64/
repo-add --verify --sign blackbird.db.tar.gz *.pkg.tar.zst
git add . &&
git commit -m "latest" &&
git push &&
cd ../../youget &&
git add . &&
git commit -m "latest" &&
git push 
