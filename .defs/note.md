Sed: Mutli-Line Replacement Between Two Patterns
This post has some useful sed commands which can be used to perform replacements and deletes between two patterns across multiple lines. For example, consider the following file:
$ cat file
line 1
line 2
foo
line 3
line 4
line 5
bar
line 6
line 7
1) Replace text on each line between two patterns (inclusive):
To perform a replacement on each line between foo and bar, including the lines containing foo and bar, use the following:
$ sed '/foo/,/bar/{s/./x/g}' file
line 1
line 2
xxx
xxxxxx
xxxxxx
xxxxxx
xxx
line 6
line 7
2) Replace text on each line between two patterns (exclusive):
To perform a replacement on each line between foo and bar, excluding the lines containing foo and bar, use the following:
$ sed '/foo/,/bar/{/foo/n;/bar/!{s/./x/g}}' file
line 1
line 2
foo
xxxxxx
xxxxxx
xxxxxx
bar
line 6
line 7
3) Delete lines between two patterns (inclusive):
To delete all lines between foo and bar, including the lines containing foo and bar, use the same replacement sed command as shown above, but simply change the replacement expression to a delete.
$ sed '/foo/,/bar/d' file
line 1
line 2
line 6
line 7
4) Delete lines between two patterns (exclusive):
To delete all lines between foo and bar, excluding the lines containing foo and bar, use the same replacement sed command as shown above, but simply change the replacement expression to a delete.
$ sed '/foo/,/bar/ {/foo/n;/bar/!d}' file
line 1
line 2
foo
bar
line 6
line 7
5) Replace all lines between two patterns (inclusive):
To perform a replacement on a block of lines between foo and bar, including the lines containing foo and bar, use:
$ sed -n '/foo/{:a;N;/bar/!ba;N;s/.*\n/REPLACEMENT\n/};p' file
line 1
line 2
REPLACEMENT
line 6
line 7
How it works:
/foo/{                   # when "foo" is found
  :a                     # create a label "a"
    N                    # store the next line
  /bar/!ba               # goto "a" and keep looping and storing lines until "bar" is found
  N                      # store the line containing "bar"
  s/.*\n/REPLACEMENT\n/  # delete the lines
}
p                        # print
6) Replace all lines between two patterns (exclusive):
To perform a replacement on a block of lines between foo and bar, excluding the lines containing foo and bar, use:
$ sed -n '/foo/{p;:a;N;/bar/!ba;s/.*\n/REPLACEMENT\n/};p' file
line 1
line 2
foo
REPLACEMENT
bar
line 6
line 7


cat .gitmodules | sed -n 's/^\s*url = \(\S*\) */git submodule add \1/p' | bash
Explanation:

cat .gitmodules          # output file content
sed -n                   # output only the relevant lines
's/regEx/replacement/p'  # print the 'replacement' of the 'regEx'
^\s*url =                # look for lines starting with [whitespace]url = 
                         # but not, e.g., with #[whitespace]
\(\S*\) *                # capture all characters, ignore trailing [space] 
git submodule add \1     # append the captured URL to the git command
bash                     # execute the command




# Remove the submodule entry from .git/config
git submodule deinit -f path/to/submodule

# Remove the submodule directory from the superproject's .git/modules directory
rm -rf .git/modules/path/to/submodule

# Remove the entry in .gitmodules and remove the submodule directory located at path/to/submodule
git rm -f path/to/submodule


# enable hibernate process
1. add resume hook for initramfs
2. regenerate the initramfs
3. add resume and resume_offset option in systemd entry ie. arch.conf
4. fix wireless drive, lspci -k, modprobe on/off，dmesg frep firmware for logs

# turn off wifi power
1. sudo nano /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
2. wifi.powersave = 2
[connection]
wifi.powersave = 2
