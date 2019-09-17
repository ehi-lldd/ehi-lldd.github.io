<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tei="http://www.tei-c.org/ns/1.0">

<!--<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">>-->

<xsl:output
encoding="UTF-8"
method="html"
version="5.0"
indent="yes"
omit-xml-declaration="yes"
doctype-system="about:legacy-compat"
media-type="text/html"/>

<xsl:template match="/">
	<html lang="es">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
			<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
			<!-- Bootstrap stylesheet -->
	        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
	        <!-- Our stylesheet -->
	        <link rel="stylesheet" type="text/css" href="../css/style.css"/>
	        <link rel="stylesheet" type="text/css" href="../css/xslstyle.css"/>
	        <!-- jQuery library -->
	        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	        <!-- Bootstrap JS-->
	        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	        <!--Our JS-->
	        <script src="code.js"></script>
	        <title>
	        	Transformado automáticamente de XML TEI anotado a HTML	
	        </title>
			<!-- <title><xsl:value-of select="tei:TEI/tei:text/tei:body/tei:head"/></title> -->
		</head>

		<body>
				<!--Barra de navegación-->
				<nav class="navbar navbar-expand-md navbar-light bg-light">
		            <a class="navbar-brand" href="#">
		                <img src="../img/logoUCM.png" width="40" height="40" alt="Logo UCM"/>
		                TFM LLDD
		            </a>
        	
        			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">

            			<span class="navbar-toggler-icon"></span>
        			</button>
        
        			<div class="collapse navbar-collapse" id="navbarNavDropdown">
            			<ul class="navbar-nav">
			                <li class="nav-item">
			                    <a class="nav-link" href="./index.html">Índice</a>
			                </li>
			                <li class="nav-item active">
			                    <a class="nav-link" href="./edicion.html">Edición<span class="sr-only">(current)</span></a>
			                </li>
			                <li class="nav-item">
			                    <a class="nav-link" href="./desarrolladoras.html">Sobre nosotras</a>
			                </li>
            			</ul>
        			</div>
    			</nav>
				<div class="container">
						<div class="row separador">
							<div class="col-md-8">
								<div class="container">
									<xsl:apply-templates select="tei:TEI/tei:text/tei:body"/>
								</div>
							</div> 
							<div class="col-md-4">
								<div class="card">
									<div class="card-body">
										<button onclick="changecolor()" id="rima" type="button" class="btn btn-info btn-block">Rima</button><br/>
										<button onclick="showmetrica()" id="metrica" type="button" class="btn btn-info btn-block">Métrica</button>
									</div>
								</div>
							</div>
						</div>
						<hr/>
						<div class="row">
							<div class="col-sm-6">
								<div class="card">
		    						<h5 class="card-header">
		    							<em><xsl:value-of select="tei:TEI/tei:text/tei:intertext/tei:head"/></em>
		    						</h5>
		    						<div class="card-body">
		    							<p class="card-text">
		    								<xsl:apply-templates select="tei:TEI/tei:text/tei:intertext/tei:sourceDesc"/>
		    							</p>
		    							<div><xsl:apply-templates select="tei:TEI/tei:text/tei:intertext/tei:link"/></div>
		  							</div>
								</div>
							</div>
						</div>
				<!-- <br/> -->
			</div>




		</body>
	</html>			
</xsl:template>
     

<xsl:template match="tei:TEI/tei:text/tei:body/tei:head">
	<h1 class="display-4 separador-titulo">
		<xsl:apply-templates/>
	</h1>
</xsl:template>

<xsl:template match="tei:TEI/tei:text/tei:body/tei:lg">
	<div class="metrica hidden">
		<p style="color: blue;"><em>Estrofa</em>: <xsl:value-of select="@type"/></p>
	</div>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="*/tei:rhyme">
	<span class="rhyme">
		<xsl:apply-templates/>
	</span>
</xsl:template>

<xsl:template match="*/tei:l">
	<xsl:apply-templates/>
	<br/>
</xsl:template>

<xsl:template match="*/tei:lg/tei:lg">
	<p class="estrofa" hidden="true">
		Estrofa | Métrica | Rima: <xsl:value-of select="@type"/> | <xsl:value-of select="@met"/> | <xsl:value-of select="@rhyme"/>
	</p>
	<p>
		<xsl:apply-templates/>
	</p>
</xsl:template>

<xsl:template match="*/tei:intertext/tei:sourceDesc">
	<xsl:for-each select="tei:bibl">
		<b>Autor</b>: <xsl:value-of select="tei:author"/>
		<br/>
		<b>Título</b>: <em><xsl:value-of select="tei:title"/></em>
		<br/>
		<b>Editorial</b>: <xsl:value-of select="tei:publisher"/>
		<br/>
		<b>Año de publicación</b>: <xsl:value-of select="tei:date"/>
	</xsl:for-each>
</xsl:template>

<xsl:template match="tei:link"><a href="{@target}" class="btn btn-primary btn-block">
	<xsl:value-of select="."/>
	Leer intertexto</a>
</xsl:template>

</xsl:stylesheet>