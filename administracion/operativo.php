<?php
	if (session_id() == "") {
		session_start();
	}
	include '../conecta.php';

	ini_set('default_charset', 'UTF-8');

	$id_usu = $_SESSION['idusu'];
	$id_region = $_SESSION['region'];
	$tipousu = $_SESSION['tipou'];
	$nombre = $_SESSION['nombreu'];
	$devoluciones = false;
	$vig=$_SESSION['vigencia']; $anterior = $vig - 1; $nuevas=9; $deuda = 5; $novedades = "(1,2,3,4,6,10,12,13,97,41,19)"; $rinden = "(99,5)";
	$sind = 0; $dist = ">0"; $digi = 2; $digit = 3; $crit = 4; $verif = 5; $acepta = 6; $porce = false; $valorBase = 0;
	if (isset($_GET['nreg']) AND $_GET['nreg'] > 0) {
		$regOpe = $_GET['nreg'];
		$_GET['nreg'] = 0;
		unset($_GET['nreg']);
	}
	else {
		$regOpe = $_SESSION['region'];
	}
	if ($_SESSION['region'] == 99) {
		$campoUsu = "usuario";
	}
	else {
		$campoUsu = "usuarioss";
	}

	$data_chart = array("AR"=>0, "SD"=>0, "DIST"=>0, "END"=>0, "DIG"=>0, "CRIT"=>0, "ENV"=>0, "ACEP"=>0, "NOV"=>0);

	$lineas = array("Directorio Base"=>1,
		 "Nuevos"=>2,
		 "Total a Recolectar"=>3,
		 "Sin Distribuir"=>4,
		 "Distribuidos"=>5,
		 "Pendientes"=>6,
		 "En Digitaci&oacute;n"=>7,
		 "Digitados"=>8,
		 "An&aacute;lisis Verificaci&oacute;n"=>9,
		 "Verificados"=>10,
		 "Aceptados"=>11,
		 "Novedades"=>12);
	if (substr($id_usu,0,4)=="CO99" OR substr($id_usu,0,2)=="AT" OR substr($id_usu,0,4)=="CR99") {
		$lista = true;
	}
	else {
		$lista = false;
	}
	if (($tipousu == "CO" OR $tipousu == "CR") AND $_SESSION['region'] == 99) {
		$qRegion = $conn->query("SELECT codis, nombre FROM regionales ORDER BY codis");
	}
	else {
		if ($tipousu == "AT")
			$qRegion = $conn->query("SELECT codis, nombre FROM regionales WHERE codireg = $id_region ORDER BY codis");
	}
	if ($_SESSION['region'] == 99) {
		if ($tipousu == "CO") {
			$qDevolucion = $conn->query("SELECT a.*, b.estado FROM devoluciones a, control b WHERE a.vigencia = $vig AND b.estado = 4 AND a.nordemp = b.nordemp AND a.tipo = 'DEV' ORDER BY nordemp, fecha");
		}
		elseif ($tipousu == "CR") {
			$qDevolucion = $conn->query("SELECT a.*, b.estado FROM devoluciones a, control b WHERE a.vigencia = $vig AND a.coddev = '$id_usu' AND b.estado = 4 AND a.nordemp = b.nordemp AND a.tipo = 'DEV' ORDER BY nordemp, fecha");
		}
	}
	else {
		if ($tipousu == "CO" OR $tipousu == "AT") {
			$qDevolucion = $conn->query("SELECT a.*, b.estado FROM devoluciones a, control b WHERE a.vigencia = $vig AND a.codsede = $regOpe AND b.estado = 4 AND a.nordemp = b.nordemp AND a.tipo = 'DEV' ORDER BY nordemp, fecha");
		}
		elseif ($tipousu == "CR") {
			$qDevolucion = $conn->query("SELECT a.*, b.estado FROM devoluciones a, control b WHERE a.vigencia = $vig AND a.codsede = $regOpe AND a.codcrit = '$id_usu' AND b.estado = 4 AND a.nordemp = b.nordemp AND a.tipo = 'DEV' ORDER BY nordemp, fecha");
		}
	}
	if ($qDevolucion->rowCount() > 0) {
		$devoluciones = true;
		$numdev = $qDevolucion->rowCount();
	}
	$qNregion = $conn->prepare("SELECT nombre FROM regionales WHERE codis = :nRegion");
	$qNregion->execute(array(':nRegion'=>$regOpe));
	$rowRegion = $qNregion->fetch(PDO::FETCH_ASSOC);

	/** Consulta de periodos creados */


	$qPerac = $conn->query("SELECT id, estperiodo, nomperiodo, anioperiodo FROM periodoactivo order by id desc");
	/** Consulta de periodos creados */
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
		<title> <?php echo $_SESSION['titulo'] . 'Operativo'; ?> </title>
		<link href="../bootstrap/img/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon">
		<!-- Bootstrap -->
		<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
		<link href="../bootstrap/css/custom.css" rel="stylesheet">
		<link href="../bootstrap/css/sticky-footer.css" rel="stylesheet">
		<script src="../bootstrap/js/jquery.js"></script>
		<script src="../bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/validator.js"></script>
		<script type="text/javascript" src="../js/html5shiv.js"></script>
		<script type="text/javascript" src="../js/respond.js"></script>
		<script type="text/javascript" src="../js/css3-mediaqueries.js"></script>
		<script type="text/javascript" src="../charts/amcharts/amcharts.js"></script>
		<script type="text/javascript" src="../charts/amcharts/serial.js"></script>
		<style type="text/css"> p {font-size: 13px !important;}</style>
		<script type="text/javascript" src="../js/periodo.js"></script>
		<script type="text/javascript">
			function reloadOpe(regsel)
			{
				var newloc = "operativo.php?nreg="+regsel;
				window.location = newloc;
			}

			$(function() {
	            $("#idopera").submit(function(event) {
	                event.preventDefault();
					if ($.isNumeric($("#txtBusca").val()))
					{
						$.ajax({
							url: "../persistencia/opFormulario.php",
							type: "POST",
							data: {accion: "verifica", numero: $("#txtBusca").val()},
							success: function(dato) {
								if (dato=="") {
									var newloc = "../interface/caratula.php?numero="+$("#txtBusca").val();
									window.location = newloc;
								}
								else {
									alert(dato);
								}
							}
						});
					}
					else {
						var newloc = "listaOpera.php?bNom=SI&texto="+$("#txtBusca").val();
						window.open(newloc, "_blank");
						//var newloc = "listaOpera.php?bNom=SI&texto="+$("#txtBusca").val();
						//window.location = newloc;
					}
				});
			});

			$(document).ready(function(){
				$('[data-toggle="tooltip"]').tooltip();
			});


		</script>
	</head>
	<body style="padding-top: 60px; ">
		<?php
			include 'menuCOCR.php';
			if ($tipousu == "CO") {
				include 'menuCO.php';
			}

		?>
		<!--br/><br/><br/><br/>
		<div class="container">
			<div class="row col-xs-12 ">
				<div class="col-xs-12">
					<div class="panel panel-default">
						<div class="panel-heading">Sesiones</div>
						<div class="panel-body">
							Sesiones: <?php echo  print_r($_SESSION); ?>
						</div>
					</div>
				</div>

			</div>
		</div-->

		<div class="container">
			<div class="row col-xs-12 small">
				<div class="form-group form-group-sm col-xs-3">
					<select class='form-control' id="periodo" name="periodo">
						<option value="">Seleccione el periodo</option>
						<?php foreach ($qPerac as $per){?>
							<option value="<?php echo $per['id']; ?>"><?php echo $per['nomperiodo']; ?></option>
						<?php } ?>
					</select>
				</div>

				<div class="form-group form-group-sm col-xs-12 col-sm-5 ">
					<div class='input-group input-group-sm'>
						<span class="input-group-addon" id="sizing-addon1">Periodo Activo</span>
						<input type='text' class='form-control text-center ' value="<?php echo $_SESSION['nomPeri']; ?>" />
					</div>
				</div>
			</div>
		</div>
		<br/>
		<form class='form-horizontal' role='form' name="opera" id="idopera" method="post">
			<div class="container">
				<div class="row col-sm-3">
					<?php
						if ($lista) {
							echo "<select class='form-control' id='listareg' onChange='reloadOpe(this.value);'>";
							echo "<option value='0'>Seleccione una sede....</option>";
							foreach($qRegion AS $lRegion) {
								echo "<option value=" . $lRegion['codis'] . ">" . $lRegion['nombre'] . "</option>";
							}
							echo "</select>";
						}
					?>
				</div>
				<div class="row">
					<div class="col-lg-5">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Buscar..." id="txtBusca">
							<span class="input-group-btn">
								<button class="btn btn-default" type="submit">Buscar</button>
							</span>
						</div>
					</div>
					<span class='pull-right'>
						<select class='form-control input-sm' onChange='window.location.href=this.value;'>
							<option value=''>Descarga Documentos</option>
							<option value='../documentos/evac_formulario_borrador.pdf'>Formulario Borrador</option>
							<option value='../documentos/evac_manual_fuente.pdf'>Manual de Diligenciamiento</option>
							<!-- <option value='../documentos/GLOSARIODETERMINOS_EDIT_SERVICIOS_2016.pdf'>Glosario de T&eacute;rminos</option> -->
							<option value='../documentos/evac_manual_critica.pdf'>Manual de Cr&iacute;tica</option>
						</select>
					</span>
				</div>
			</div>
		</form>
		<div class="container" style="margin-top: 10px">
			<div class="col-md-6">
				<table class='table table-condensed table-hover'>
					<thead>
						<tr>
							<th class="text-center">Avance Operativo</th>
							<th class='text-right'>Prio. 1</th>
							<th class='text-right'>Prio. 2</th>
							<th class='text-right'>Resto</th>
							<th class='text-right'>TOTAL</th>
							<th class='text-right'>%</th>
						</tr>
					</thead>
					<tbody>
						<?php
							$valorBase = 0;
							foreach($lineas as $descrip=>$valor) {
								if ($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") {
									$query = "SELECT ifnull(prio2, 'total') AS columna, count( prio2 ) AS priori FROM control WHERE vigencia = :periodo";
									if ($regOpe != 99) {
										$query .= " AND codsede = :region";
									}
								}
								if ($tipousu == "CR") {
									$query = "SELECT ifnull(prio2, 'total') AS columna, count( prio2 ) AS priori FROM control WHERE vigencia = :periodo AND $campoUsu = :idUsuario";
									if ($regOpe != 99) {
										$query .= " AND codsede = :region";
									}
								}
								if ($valor == 1) {
									$query .= " AND novedad != :noved GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas));
										$parametro = "?periodo=$vig&noved=No9";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&noved=No9&sede=$regOpe";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas, ':idUsuario'=>$id_usu));
										$parametro = "?periodo=$vig&noved=No9&usuario=$id_usu";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas, ':idUsuario'=>$id_usu, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&noved=No9&usuario=$id_usu&sede=$regOpe";
									}
								}
								if ($valor == 2) {
									$query .= " AND novedad = :noved GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas));
										$parametro = "?periodo=$vig&noved=$nuevas";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&noved=$nuevas&sede=$regOpe";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas, ':idUsuario'=>$id_usu));
										$parametro = "?periodo=$vig&noved=$nuevas&usuario=$id_usu";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':noved'=>$nuevas, ':idUsuario'=>$id_usu, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&noved=$nuevas&usuario=$id_usu&sede=$regOpe";
									}
								}
								if ($valor == 3) {
									$query .= " GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig));
										$parametro = "?periodo=$vig";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&sede=$regOpe";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu));
										$parametro = "?periodo=$vig&usuario=$id_usu";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe";
									}
								}
								if ($valor == 4) {
									$query .= " AND estado = :estado GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':estado'=>$sind));
										$parametro = "?periodo=$vig&estado=$sind";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe, ':estado'=>$sind));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$sind";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':estado'=>$sind));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$sind";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe, ':estado'=>$sind));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$sind";
									}
								}
								if ($valor == 5) {
									$query .= " AND estado >0 GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig));
										$parametro = "?periodo=$vig&estado=$dist";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$dist";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$dist";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$dist";
									}
								}
								if ($valor == 6) {
									/*/ $query .= " AND novedad = :noved GROUP BY prio2 WITH ROLLUP";*/
									$query .= " AND novedad NOT IN $novedades AND (estado = 1 OR estado = 0) GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig));
										$parametro = "?periodo=$vig&noved=novedad";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&noved=novedad&sede=$regOpe";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu));
										$parametro = "?periodo=$vig&noved=novedad&usuario=$id_usu";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&noved=novedad&usuario=$id_usu&sede=$regOpe";
									}
								}
								if ($valor == 7) {
									$query .= " AND estado = :estado GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':estado'=>$digi));
										$parametro = "?periodo=$vig&estado=$digi";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe, ':estado'=>$digi));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$digi";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':estado'=>$digi));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$digi";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe, ':estado'=>$digi));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$digi";
									}
								}
								if ($valor == 8) {
									$query .= " AND estado = :estado GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':estado'=>$digit));
										$parametro = "?periodo=$vig&estado=$digit";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe, ':estado'=>$digit));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$digit";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':estado'=>$digit));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$digit";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe, ':estado'=>$digit));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$digit";
									}
								}
								if ($valor == 9) {
									$query .= " AND estado = :estado GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':estado'=>$crit));
										$parametro = "?periodo=$vig&estado=$crit";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe, ':estado'=>$crit));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$crit";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':estado'=>$crit));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$crit";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe, ':estado'=>$crit));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$crit";
									}
								}
								if ($valor == 10) {
									$query .= " AND estado = :estado GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':estado'=>$verif));
										$parametro = "?periodo=$vig&estado=$verif";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe, ':estado'=>$verif));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$verif";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':estado'=>$verif));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$verif";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe, ':estado'=>$verif));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$verif";
									}
								}
								if ($valor == 11) {
									$query .= " AND estado = :estado GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':estado'=>$acepta));
										$parametro = "?periodo=$vig&estado=$acepta";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe, ':estado'=>$acepta));
										$parametro = "?periodo=$vig&sede=$regOpe&estado=$acepta";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':estado'=>$acepta));
										$parametro = "?periodo=$vig&usuario=$id_usu&estado=$acepta";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe, ':estado'=>$acepta));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&estado=$acepta";
									}
								}
								if ($valor == 12) {
									$query .= " AND novedad IN $novedades GROUP BY prio2 WITH ROLLUP";
									$linea = $conn->prepare($query);
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig));
										$parametro = "?periodo=$vig&noved=todo";
									}
									if (($tipousu == "CO" OR $tipousu == "TE" OR $tipousu == "AT") AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&sede=$regOpe&noved=todo";
									}
									if ($tipousu == "CR" AND $regOpe == 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu));
										$parametro = "?periodo=$vig&usuario=$id_usu&noved=todo";
									}
									if ($tipousu == "CR" AND $regOpe != 99) {
										$linea->execute(array(':periodo'=>$vig, ':idUsuario'=>$id_usu, ':region'=>$regOpe));
										$parametro = "?periodo=$vig&usuario=$id_usu&sede=$regOpe&noved=todo";
									}
								}
								if ($valor == 9 AND $devoluciones) {
									echo "<tr><td>" . $descrip . " <a href='listaDev.php' style='color: red' data-toggle='tooltip' title='Formularios Devueltos'>[DEV" . " - " . $numdev . "]</a></td>";
								}
								else {
									echo "<tr><td>" . $descrip . "</td>";
								}
								$valor1=0; $valor2=0; $valor3=0; $valor4=0;
								while ($row = $linea->fetch(PDO::FETCH_ASSOC)) {
									switch ($row['columna']) {
										case 1:
											$valor1 = $row['priori'];
											break;
										case 2:
											$valor2 = $row['priori'];
											break;
										case 9:
											$valor3 = $row['priori'];
											break;
										default:
											$valor4 = $row['priori'];
											break;
									}
									if ($valor == 3) {
										$valorBase = $valor4;
									}
									if ($valor > 3) {
										$porce = true;
									}
								}
								$lineaOp = armaLinea($valor1,$valor2,$valor3,$valor4, $valorBase, $parametro, $porce);
								echo $lineaOp;
								echo "</tr>";

								switch ($valor) {
									case 3:
										$data_chart['AR']=$valor4;
										break;
									case 4:
										$data_chart['SD']=$valor4;
										break;
									case 5:
										$data_chart['DIST']=$valor4;
										break;
									case 7:
										$data_chart['END']=$valor4;
										break;
									case 8:
										$data_chart['DIG']=$valor4;
										break;
									case 9:
										$data_chart['CRIT']=$valor4;
										break;
									case 10:
										$data_chart['ENV']=$valor4;
										break;
									case 11:
										$data_chart['ACEP']=$valor4;
										break;
									case 12:
										$data_chart['NOV']=$valor4;
										break;
								}
							}
						?>
						<script type="text/javascript">
							var chart = AmCharts.makeChart("divchart", {
								"type": "serial",
								"theme": "light",
								"dataProvider": [{
									"estado": "A Recolectar",
									"valor": <?php echo $data_chart['AR']?>
								}, {
									"estado": "Sin Dist.",
									"valor": <?php echo $data_chart['SD']?>
								}, {
									"estado": "Dist.",
									"valor": <?php echo $data_chart['DIST']?>
								}, {
									"estado": "En Digit.",
									"valor": <?php echo $data_chart['END']?>
								}, {
									"estado": "Digitados",
									"valor": <?php echo $data_chart['DIG']?>
								}, {
									"estado": "Cr\xEDtica",
									"valor": <?php echo $data_chart['CRIT']?>
								}, {
									"estado": "Enviados",
									"valor": <?php echo $data_chart['ENV']?>
								}, {
									"estado": "Aceptados",
									"valor": <?php echo $data_chart['ACEP']?>
								}, {
									"estado": "Novedades",
									"valor": <?php echo $data_chart['NOV']?>
								}],
								"valueAxes": [{
									"gridColor":"#575555",
									"gridAlpha": 0.2,
									"dashLength": 0
								}],
								"graphs": [{
									"balloonText": "[[category]]: <b>[[value]]</b>",
									"fillAlphas": 0.5,
									"lineAlpha": 0.8,
									"bullet": "round",
									"type": "column",
									"valueField": "valor"
								}],
								"chartCursor": {
									"categoryBalloonEnabled": false,
									"cursorAlpha": 0,
									"zoomable": false
								},
								"categoryField": "estado",
								"categoryAxis": {
									"gridPosition": "start",
									"gridAlpha": 0,
									"tickPosition":"start",
									"tickLength":20,
									"labelRotation":45,
								}
							});
						</script>
					</tbody>
				</table>
			</div>

 			<div id="divchart" class="col-md-7" style = 'position: absolute; left: 50%; width:45%; height:400px; border: solid 1px #000; margin-top: 20px; padding: 10px'>
			</div>
		</div>

		<?php
			function armaLinea($v1,$v2,$v3,$v4,$base,$params,$pr) {
				$lineaOp = "";
				if ($v1 > 0) {
					$lineaOp .= "<td style='text-align: right'><a href='listaOpera.php" . $params . "&prio=1' target=\"_blank\">" . $v1 . "</td>";
				}
				else {
					$lineaOp .= "<td style='text-align: right'>0</td>";
				}
				if ($v2 > 0) {
					$lineaOp .= "<td style='text-align: right'><a href='listaOpera.php" . $params . "&prio=2' target=\"_blank\">" . $v2 . "</td>";
				}
				else {
					$lineaOp .= "<td style='text-align: right'>0</td>";
				}
				if ($v3 > 0) {
					$lineaOp .= "<td style='text-align: right'><a href='listaOpera.php" . $params . "&prio=9' target=\"_blank\">" . $v3 . "</td>";
				}
				else {
					$lineaOp .= "<td style='text-align: right'>0</td>";
				}
				if ($v4 > 0) {
					$lineaOp .= "<td style='text-align: right'><a href='listaOpera.php" . $params . "&prio=total' target=\"_blank\">" . $v4 . "</td>";
				}
				else {
					$lineaOp .= "<td style='text-align: right'>0</td>";
				}
				if ($pr) {
					$porcent = round($v4*100/$base, 2);
					$lineaOp .= "<td style='text-align: right'>" . $porcent . "</td>";
				}
				else {
					$lineaOp .= "<td style='text-align: right'>&nbsp;</td>";
				}
				return $lineaOp;
			}
		?>
 	</body>
 </html>
