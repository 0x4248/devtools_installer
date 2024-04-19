# Devtools installer
# A simple program to select and install packages with a terminal menu interface.
# Github: https://www.github.com/0x4248/devtools_installer
# Licence: GNU General Public License v3.0
# By: 0x4248

import os

def readAndParseConfig():
    with open('.config', 'r') as f:
        file = f.readlines()
    packages = []

    with open('conf/ignore.txt', 'r') as f:
        ignore_file = f.readlines()
    
    ignored_lines = []
    for line in ignore_file:
        if line[0] == '#':
            continue
        if line == '\n':
            continue
        ignored_lines.append(line.strip())

    for line in file:
        if line[0] == '#':
            continue
        if line == '\n':
            continue
        if line.startswith('CONFIG'):
            if line.split('=')[0] in ignored_lines:
                continue

            package_name = line.split('=')[0].strip()
            package_name = package_name.split('CONFIG_')[1]
            package_name = package_name.replace('_PLUS_', '+')
            packages.append(package_name)
            print(f'Package: {package_name}')
    return packages

def installPackages(packages):
    packages = ' '.join(packages)
    print(f'Installing packages: {packages}')
    os.system(f'apt install {packages}')

def main():
    packages = readAndParseConfig()
    installPackages(packages)

main()