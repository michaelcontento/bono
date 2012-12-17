from optparse import OptionParser
from os.path import realpath
import sys
import logging

def parse_args():
    parser = OptionParser(usage="usage: %prog [options] WORKDIR")
    parser.add_option("-t", "--target",
        help="target to work on (android, ios, ...)", metavar="TARGET")
    parser.add_option("-m", "--mode",
        help="mode to work in (revmob, payment, ...)", metavar="MODE")
    parser.add_option("-v", "--verbose", action="store_true", default=False)

    (options, args) = parser.parse_args()

    if options.target is None:
        parser.print_help()
        sys.stdout.write("\n")
        logging.error("option --target missing")
        sys.exit(2)

    if options.mode is None:
        parser.print_help()
        sys.stdout.write("\n")
        logging.error("option --mode missing")
        sys.exit(2)

    if len(args) != 1:
        parser.print_help()
        sys.stdout.write("\n")
        logging.error("argument WORKDIR missing")
        sys.exit(2)

    return (options, args[0])

def configure_logging(is_verbose):
    if is_verbose:
        level = logging.DEBUG
    else:
        level = logging.WARNING

    logging.basicConfig(format="[%(asctime)s] %(levelname)s: %(message)s",
        datefmt="%Y/%m/%d %H:%M:%S", level=level)

def run():
    configure_logging(False)
    (options, workdir) = parse_args()
    configure_logging(options.verbose)

    modpath = ".".join(["wizard", options.target, options.mode])

    try:
        module = __import__(modpath, fromlist=[modpath + ".run"])
    except:
        logging.exception("unable to load method run from module %s", modpath)
        sys.exit(2)

    try:
        module.run(options, realpath(workdir))
    except:
        logging.exception("something went wrong in %s.run", modpath)
        sys.exit(2)
