<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!--  >%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%-->
<%@ attribute name="name" required="true" rtexprvalue="true"
	description="Name of the active menu: home, owners, vets or error"%>

<nav class="navbar navbar-default" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand"
				href="<spring:url value="/" htmlEscape="true" />"><span></span></a>
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#main-navbar">
				<span class="sr-only"><os-p>Toggle navigation</os-p></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<div class="navbar-collapse collapse" id="main-navbar">
			<ul class="nav navbar-nav">

				<petclinic:menuItem active="${name eq 'home'}" url="/"
					title="pagina de inicio">
					<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
					<span>Inicio</span>
				</petclinic:menuItem>

				<petclinic:menuItem active="${name eq 'owners'}" url="/owners/find"
						title="propietarios">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						<span>Propietarios</span>
				</petclinic:menuItem>
				
				<sec:authorize access="hasRole('admin')">
					<petclinic:menuItem active="${name eq 'vets'}" url="/vets"
						title="veterinarios">
						<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
						<span>Veterinarios</span>
					</petclinic:menuItem>
				</sec:authorize>

				<petclinic:menuItem active="${name eq 'causes'}" url="/causes"
					title="Causas">
					<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
					<span>Causas</span>
				</petclinic:menuItem>

				<sec:authorize access="isAuthenticated()">
					<c:if test="${currentPlan.name ne 'BASIC'}">
						<petclinic:menuItem active="${name eq 'bookings'}" url="/booking/list"
							title="reservas">
							<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
							<span>Reservas</span>
						</petclinic:menuItem>
					</c:if>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<c:if test="${currentPlan.name ne 'BASIC'}">
						<petclinic:menuItem active="${name eq 'adoptionRequest'}" url="/adoptionRequest/list"	
							title="Adopciones">
							<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
							<span>Adopciones</span>
						</petclinic:menuItem>
					</c:if>
				</sec:authorize>

				<petclinic:menuItem active="${name eq 'adoptionRequest'}" url="/users/CA"	
					title="Acuerdo">
					<span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
					<span>Acuerdo</span>
				</petclinic:menuItem>
			</ul>




			<ul class="nav navbar-nav navbar-right">
				<sec:authorize access="!isAuthenticated()">
					<li><a href="<c:url value="/login" />">Iniciar Sesion</a></li>
					<li><a href="<c:url value="/users/new" />">Registrarse</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <span class="glyphicon glyphicon-user"></span>�
							<strong><sec:authentication property="name" /></strong> <span
							class="glyphicon glyphicon-chevron-down"></span>
					</a>
						<ul class="dropdown-menu">
							<li>
								<div class="navbar-login">
									<div class="row">
										<div class="col-lg-4">
											<p class="text-center">
												<span class="glyphicon glyphicon-user icon-size"></span>
											</p>
										</div>
										<div class="col-lg-8">
											<p class="text-left">
												<strong><sec:authentication property="name" /></strong>
													<a>${currentPlan.getName()}</a> 

											</p>
											<p class="text-left">
												<a href="<c:url value="/custom-logout" />"
													class="btn btn-primary btn-block btn-sm">Cerrar Sesion</a>

											</p>
										</div>
									</div>
								</div>
							</li>
							<li class="divider"></li>
<!-- 							
                            <li> 
								<div class="navbar-login navbar-login-session">
									<div class="row">
										<div class="col-lg-12">
											<p>
												<a href="#" class="btn btn-primary btn-block">My Profile</a>
												<a href="#" class="btn btn-danger btn-block">Change
													Password</a>
											</p>
										</div>
									</div>
								</div>
							</li>
-->
						</ul></li>
				</sec:authorize>
			</ul>
		</div>



	</div>
</nav>
