#!/bin/bash
# This file is part of VPL for Moodle
# Script for debugging Python language
# Copyright (C) 2012 Juan Carlos Rodríguez-del-Pino
# License http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
# Author Juan Carlos Rodríguez-del-Pino <jcrodriguez@dis.ulpgc.es>

# @vpl_script_description Using default python pdb with the first file
# load common script and check programs
. common_script.sh
check_program python3 python python2
# Detect if PuDB is installed
PUDB=$($PROGRAM -c 'import pudb; print(1)' 2>/dev/null)
if [ "$PUDB" == "1" ] ; then
	MOD=pudb
else
	MOD=pdb
fi

get_first_source_file py
cat common_script.sh > vpl_execution
echo "TERM=ansi" >>vpl_execution
echo "$PROGRAM -m $MOD \"$FIRST_SOURCE_FILE\"" >>vpl_execution
chmod +x vpl_execution
if [ "$PUDB" == "1" ] ; then
	mv vpl_execution debug_execution
	cat common_script.sh > vpl_wexecution
	echo "x-terminal-emulator -e ./debug_execution" >> vpl_wexecution
	echo "sleep 2h" >> vpl_wexecution
	chmod +x debug_execution
fi
