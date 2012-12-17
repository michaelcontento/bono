import logging
from sh import cp, patch, cat, mkdir
from os.path import realpath, dirname

def copy_library(filespath, workdir):
    logging.info("copying third party library: AndroidBillingLibrary")

    fromdir = filespath + "/AndroidBillingLibrary/AndroidBillingLibrary/src"
    logging.debug("fromdir: %s", fromdir)

    todir = workdir + "/src_AndroidBillingLibrary/"
    logging.debug("todir: %s", todir)

    mkdir("-p", todir)
    cp("-r", fromdir, todir)

def patchhelper(patchfile, targetfile):
    logging.debug("patchfile: %s", patchfile)
    logging.debug("target: %s", targetfile)
    patch("-N", targetfile, patchfile, _ok_code=[0, 1])

def patch_androidmanifest(filespath, workdir):
    logging.info("adding permissions and reciever to AndroidManifest.xml")
    patchfile = filespath + "/AndroidManifest.xml.patch"
    targetfile = workdir + "/templates/AndroidManifest.xml"
    patchhelper(patchfile, targetfile)

def patch_buildxml(filespath, workdir):
    logging.info("adding library files to the project")
    patchfile = filespath + "/build.xml.patch"
    targetfile = workdir + "/build.xml"
    patchhelper(patchfile, targetfile)

def patch_library(filespath, workdir):
    logging.info("patching BillingRequest.java within AndroidBillingLibrary")
    patchfile = filespath + "/AndroidBillingLibrary.patch"
    targetfile = workdir + "/src_AndroidBillingLibrary/src/net/robotmedia/billing/BillingRequest.java"
    patchhelper(patchfile, targetfile)

def run(options, workdir):
    filespath = dirname(__file__) + "/files/payment"

    copy_library(filespath, workdir)
    patch_androidmanifest(filespath, workdir)
    patch_buildxml(filespath, workdir)
    patch_library(filespath, workdir)
