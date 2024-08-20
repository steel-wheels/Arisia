# `vim` support

## How to support ArisiaScript file

Reference: https://easyramble.com/set-vim-indent-with-filetype.html (Japanese)

### Step 1: Indent for each file types
Add following lines into <code>~/.vimrc</code>
<pre>
filetype plugin indent on
</pre>

### Step 2: Define file type by <code>~/.vim/filetype.vim</code>
Edit the <code>~/.vim/filetype.vim</code>
<pre>
augroup filetypedetect
        au BufRead,BufNewFile *.as setfiletype arisia_script
augroup END
</pre>

 ### Step 3: Setting for each file types
 Edit the <code>~/.vim/ftplugin/arisia_script.vim</code> to support ArisiaScript.
<pre>
set tabstop=4
</pre>

# Related links
* [Arisia Platform](https://gitlab.com/steewheels/arisia/-/blob/main/README.md)
* [Kiwi Library](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Library.md)
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md)



