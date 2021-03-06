#!/bin/bash
#
# Copyright (c) 1997, 2018 Oracle and/or its affiliates. All rights reserved.
#
# This program and the accompanying materials are made available under the
# terms of the Eclipse Public License v. 2.0, which is available at
# http://www.eclipse.org/legal/epl-2.0.
#
# This Source Code may also be made available under the following Secondary
# Licenses when the conditions for such availability set forth in the
# Eclipse Public License v. 2.0 are satisfied: GNU General Public License,
# version 2 with the GNU Classpath Exception, which is available at
# https://www.gnu.org/software/classpath/license.html.
#
# SPDX-License-Identifier: EPL-2.0 OR GPL-2.0 WITH Classpath-exception-2.0
#

echo *************************************************************************
echo *
echo *  Test for $1, $2, $3
echo *
echo *************************************************************************

mvn -N -Pweblogic-patch clean install

if [ "$?" -ne "0" ]; then
    exit $?
fi

mvn -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 clean install

if [ "$?" -ne "0" ]; then
    exit $?
fi

mvn -N -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 com.oracle.weblogic:wls-maven-plugin:start-server

if [ "$?" -ne "0" ]; then
    exit $?
fi

mvn -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 pre-integration-test

if [ "$?" -ne "0" ]; then
    mvn -N -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 com.oracle.weblogic:wls-maven-plugin:stop-server
    exit $?
fi

mvn -U -Pintegration -Dintegration.serverPort=7001 verify

if [ "$?" -ne "0" ]; then
    mvn -N -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 com.oracle.weblogic:wls-maven-plugin:stop-server
    exit $?
fi

mvn -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 post-integration-test

if [ "$?" -ne "0" ]; then
    mvn -N -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 com.oracle.weblogic:wls-maven-plugin:stop-server
    exit $?
fi

mvn -N -Pweblogic-cargo -Dwebapp.projectStage=$1 -Dwebapp.partialStateSaving=$2 -Dwebapp.stateSavingMethod=$3 com.oracle.weblogic:wls-maven-plugin:stop-server

if [ "$?" -ne "0" ]; then
    exit $?
fi
