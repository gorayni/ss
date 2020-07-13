import argparse
import pathlib
import json
import time

from addict import Dict as adict

def main(conf):
    print(conf)
    print("Wait 30 seconds")
    time.sleep(30)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('conf', type=lambda p: pathlib.Path(p).absolute(),
                        help='JSON configuration filepath')

    json_conf = parser.parse_args().conf

    with open(str(json_conf)) as json_file:
        conf = adict(json.load(json_file))

    main(conf)
