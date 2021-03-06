<%@ page contentType="text/html; UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="css" resources="blog.css"/>
<query:definition var="listQuery"
                  statement="select * from [jnt:post] as comments  where isdescendantnode(comments, ['${renderContext.mainResource.node.path}']) order by comments.[jcr:lastModified] desc"
                  limit="20"/>
<c:set target="${moduleMap}" property="editable" value="false"/>
<c:set target="${moduleMap}" property="listQuery" value="${listQuery}"/>
<template:addCacheDependency flushOnPathMatchingRegexp="\Q${renderContext.mainResource.node.path}\E/.*/comments"/>
<template:addResources type="javascript" resources="jquery.min.js,jquery.cuteTime.js"/>
<template:addResources type="inlinejavascript" key="cuteTimeInitialisation">
    <script>
        function initCuteTime() {
            $('.timestamp').cuteTime({ refresh: 60000 });
        }
        $(document).ready(function () {
            $('.timestamp').cuteTime({ refresh: 60000 });
        });
    </script>
</template:addResources>