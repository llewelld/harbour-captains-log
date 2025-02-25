#!/bin/bash
#
# This file is part of Opal and has been released into the public domain.
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: 2021-2023 Mirian Margiani
#
# See https://github.com/Pretty-SFOS/opal/blob/main/snippets/opal-render-icons.md
# for documentation.
#
# @@@ keep this line: based on template v0.3.0
#
c__FOR_RENDER_LIB__="0.3.0"

# Run this script from the same directory where your icon sources are located,
# e.g. <app>/icon-src.
source ../libs/opal-render-icons.sh
cFORCE=false

for i in raw/*.svg; do
    if [[ "$i" -nt "${i#raw/}" ]]; then
        scour "$i" > "${i#raw/}"
    fi
done

cNAME="app icon"
cITEMS=(harbour-captains-log)
cRESOLUTIONS=(86 108 128 172)
cTARGETS=(../icons/RESXxRESY)
render_batch

cNAME="theme icons"
cITEMS=(mood-{0,1,2,3,4,5}@112
        icon-m-enter-add@112
        harbour-captains-log@256)
cRESOLUTIONS=(F1)
cTARGETS=(../qml/images)
render_batch

cNAME="cover background"
cITEMS=(cover-bg)
cRESOLUTIONS=(460x736)
cTARGETS=(../qml/images)
render_batch
