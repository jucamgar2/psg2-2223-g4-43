<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- %@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %-->  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<style>
	.changelog {
		float: right;
	}

    .soporte {
        margin-right: 5;
		float: right;
	}
</style>

<petclinic:layout pageName="home">
    <h2>Bienvenido al Petclinic PSG2-2223-G4-43</h2>
    <div class="row">
        <div class="col-md-12">
            <spring:url value="/resources/images/caballito.png" htmlEscape="true" var="petsImage"/>
            <img class="img-responsive" src="${petsImage}" width="100" height="100"/>
            
        </div>
       
    </div>
    <sec:authorize access="isAuthenticated()">
        <c:out value="${model.get('message')}"/>
        <a class="btn btn-default"  href="/users/${username}">Perfil de usuario</a>
    </sec:authorize>

    <div class="changelog">
        <a class="btn btn-primary" href="/changelog">Registro de cambios</a>
    </div>

    <div class="soporte">
        <a class="btn btn-primary" href="/support">Página de soporte</a>
    </div>

    <a class="btn btn-default" target="_blank" href="${url}">¡Visítanos en esta dirección!</a>

    <script>
        var beamer_config = {
            product_id : 'jWLLrVIT55236' //DO NOT CHANGE: This is your product code on Beamer
        };
    </script>
    <script type="text/javascript" src="https://app.getbeamer.com/js/beamer-embed.js" defer="defer"></script>
</petclinic:layout>
