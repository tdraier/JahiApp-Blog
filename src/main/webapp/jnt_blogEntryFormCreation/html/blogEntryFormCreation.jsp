<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="uiComponents" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<template:addResources type="css" resources="blog.css"/>
<template:addResources type="javascript" resources="jquery.min.js,jquery.jeditable.js"/>
<jcr:nodeProperty node="${renderContext.mainResource.node}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${renderContext.mainResource.node}" name="text" var="text"/>
<jcr:nodeProperty node="${renderContext.mainResource.node}" name="jcr:createdBy" var="createdBy"/>
<jcr:nodeProperty node="${renderContext.mainResource.node}" name="jcr:created" var="created"/>

<script type="text/javascript">
    $(document).ready(function() {
        $.each(['addContent'], function(index, element) {
            if ($('#' + element).length > 0) {
                $('label[for="' + element + '"]').hide();
            }
        });
    });
</script>
<uiComponents:ckeditor selector="addContent">
{
   height : 600
}
</uiComponents:ckeditor>

    <template:tokenizedForm>
        <form id="formPost" method="post" action="${renderContext.mainResource.node.name}.addBlogEntry.do" name="blogPost">
            <input type="hidden" name="jcrNodeType" value="jnt:blogPost"/>
            <input type="hidden" name="jcrNormalizeNodeName" value="true"/>
            <input type="hidden" name="jcrParentType" value="jnt:blogPosts"/>
            <fmt:formatDate value="${created.time}" type="date" pattern="dd" var="userCreatedDay"/>
            <fmt:formatDate value="${created.time}" type="date" pattern="MMM" var="userCreatedMonth"/>
            <p class="post-info"><fmt:message key="blog.label.by"/>&nbsp;${createdBy.string}
                &nbsp;-&nbsp;<fmt:formatDate value="${created.time}" type="date" dateStyle="medium"/>
            </p>

            <p>
                <label><fmt:message key="title"/> </label>
                <input type="text" value="" name="jcr:title"/>
            </p>

            <ul class="post-tags">
                <jcr:nodeProperty node="${currentNode}" name="j:tags" var="assignedTags"/>
                <c:forEach items="${assignedTags}" var="tag" varStatus="status">
                    <li>${tag.node.name}</li>
                </c:forEach>
            </ul>
            <div class="post-content">
                <p>
                    <label><fmt:message key="blog.post"/> </label>
                    <textarea name="text" rows="10" cols="70" id="addContent"></textarea>
                </p>

                <p>
                    <label> <fmt:message key="jnt_blog.tagThisBlogPost"/> :</label>
                    <input type="text" name="j:newTag" value=""/>
                </p>

                <p>
                    <fmt:message key='jnt_blog.noTitle' var="noTitle"/>
                    <input class="button"
                           type="button"
                           tabindex="16"
                           value="<fmt:message key='blog.label.save'/>"
                           onclick="
                        if (document.blogPost.elements['jcr:title'].value == '') {
                            alert('${fn:replace(noTitle,"'","\\'")}');
                            return false;
                        }
                        <%--document.blogPost.action = '${renderContext.mainResource.node.name}/blog-content/' + encodeURIComponent(document.blogPost.elements['jcr:title'].value);--%>
                        document.blogPost.submit();"/>
                </p>
            </div>
        </form>
    </template:tokenizedForm>
