<%--

    Copyright (c) 1997, 2018 Oracle and/or its affiliates. All rights reserved.

    This program and the accompanying materials are made available under the
    terms of the Eclipse Public License v. 2.0, which is available at
    http://www.eclipse.org/legal/epl-2.0.

    This Source Code may also be made available under the following Secondary
    Licenses when the conditions for such availability set forth in the
    Eclipse Public License v. 2.0 are satisfied: GNU General Public License,
    version 2 with the GNU Classpath Exception, which is available at
    https://www.gnu.org/software/classpath/license.html.

    SPDX-License-Identifier: EPL-2.0 OR GPL-2.0 WITH Classpath-exception-2.0

--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>Nested Tables</title>
        <%@ taglib uri="http://java.sun.com/jsf/core"  prefix="f" %>
        <%@ taglib uri="http://java.sun.com/jsf/html"  prefix="h" %>
    </head>
    <body>
        <h1>Nested Tables</h1>
        <f:view>
            <h:form id="form">
                <h:dataTable id="outerData" value="#{outer}" var="outerVar">
                    <h:column id="outerColumn">
                        <h:dataTable id="innerData" value="#{inner.listDataModel}" 
                                     var="innerVar">
                            <f:facet name="header">
                                <h:outputText id="header" value="#{outerVar}" />
                            </f:facet>
                            <h:column id="innerColumn">
                                <h:inputText id="inputText" value="#{innerVar.stringProperty}" />
                            </h:column>
                        </h:dataTable>
                    </h:column>
                </h:dataTable>
                <h:commandButton id="submit" style="color: red" value="reload" />
                <p />
                <h:messages />
            </h:form>
        </f:view>
    </body>
</html>
