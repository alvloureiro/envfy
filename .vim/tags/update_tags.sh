# for cpp_src
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src && mv tags cpp

# for QT4
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/qt4/ && mv tags qt4
