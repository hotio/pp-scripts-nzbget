#!/usr/bin/env python
from __future__ import print_function

##########################################
### NZBGET SCAN SCRIPT                 ###

# Removes garbage suffixes from NZB names.
#
# NOTE: This script requires Python to be installed on your system.

### NZBGET SCAN SCRIPT                 ###
##########################################

import os
import re
import sys

# Exit codes used by NZBGet
POSTPROCESS_SKIP=95
POSTPROCESS_ERROR=94
POSTPROCESS_SUCCESS=93

# Check if the script is called from nzbget 13.0 or later
if 'NZBOP_SCRIPTDIR' not in os.environ:
   print('*** NZBGet post-processing script ***')
   print('This script is supposed to be called from nzbget (13.0 or later).')
   sys.exit(POSTPROCESS_ERROR)

if 'NZBNP_NZBNAME' not in os.environ:
   print('[WARN] Filename not found in environment')
   sys.exit(POSTPROCESS_ERROR)

fwp = re.sub('(?i)[._-](obfuscated|scrambled|nzbgeek|chamele0n|buymore|asrequested)\.nzb$', '.nzb', os.environ['NZBNP_NZBNAME'], re.IGNORECASE)
fwp = re.sub('(?i)[._-](obfuscated|scrambled|nzbgeek|chamele0n|buymore|asrequested)\.nzb$', '.nzb', fwp, re.IGNORECASE)
if fwp:
   print('[NZB] NZBNAME=%s' % fwp)

   sys.exit(POSTPROCESS_SUCCESS)

sys.exit(POSTPROCESS_SKIP)
