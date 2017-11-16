#!/usr/bin/python3.6

import subprocess

hosts = None

def get_hosts(filename='./ports.file'):
    host='http://localhost:'
    with open(filename, 'r') as f:
        r = f.readlines()
    ports = r[0].replace('\n','').split(' ')
    return [ host+e for e in ports if e != '']

def mquit():
    exit()

def mhelp():
    for i in range(len(keys)):
        print (keys[i])
        print (f'\t {info[i]}')

def mhosts():
    for i in range(len(hosts)):
        print (f'{i} {hosts[i]}')

def mchain():
    req_addr = '/chain'
    print('choose target')
    mhosts()
    inp = int(input())
    if inp not in [ i for i in range(len(hosts))]:
        print ('target not exist')
    else:
        print(f'do {hosts[inp]}{req_addr}')
        subprocess.call(['curl', f'{hosts[inp]}{req_addr}'])


keys = ['help', 'quit', 'hosts', 'chain', 'nodes-register']
info = ['for cat help', 'for quit', 'cat list of hosts',
    'do chain request to target', '']
func = [mhelp, mquit, mhosts, mchain]


if __name__ == '__main__':
    hosts = get_hosts()

    inp = ''
    while inp != 'q':
        inp = input()
        if inp in keys:
            func[keys.index(inp)]()
        else:
            print ('invalid argument')

        
        