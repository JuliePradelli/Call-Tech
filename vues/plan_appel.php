<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>TRANSFERT</title>

    <!-- Bootstrap Core CSS -->
    <link href="/vue/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/vue/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Theme CSS -->
    <link href="/vue/css/agency.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top" class="index">

    <!-- Navigation -->
    <nav id="mainNav" class="navbar navbar-default navbar-custom navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">Call'tech</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
		    <li>
                        <a class="page-scroll" href="index.php?page=gestion_utilisateurs_groupes">Utilisateurs</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=gestion_salles_conf">Conférences</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=plan_appel">Transfert</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=creation_gestion_contexte">Contextes</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=gestion_gateways">Gateways</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=standard">Standard</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <section id="services">
	<?php if(isset($alerte)){echo $alerte;}?>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Changer le plan d'appel</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form  action="index.php?page=plan_appel" method="post" role="form">
                        <div class="row">
                            <div class="col-md-offset-2 col-md-8">  
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Username</span>
                                      <input type="text" name="username" class="form-control" placeholder="USERNAME DU COMPTE SIP" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Contexte</span>
                                      <input type="text" name="contexte" class="form-control" placeholder="CONTEXTE DE L'UTILISATEUR SIP" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
				<div class="radio">
  					<label style="color:black;"><input type="radio" name="transfert_o">Transfert</label><br>
  					<label style="color:black;"><input type="radio" name="transfert_n">Pas de transfert</label>
				</div>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Numero</span>
                                      <input type="text" name="numero" class="form-control" placeholder="NUMERO MOBILE DE L'UTILISATEUR" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                <br/>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-lg-12 text-center">
                                <div id="success"></div>
                                <button type="submit" class="btn btn-xl">Envoyer</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <span class="copyright">Copyright &copy; Your Website 2016</span>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline social-buttons">
                        <li><a href="#"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline quicklinks">
                        <li><a href="#">Privacy Policy</a>
                        </li>
                        <li><a href="#">Terms of Use</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    <!-- Portfolio Modals -->
    <!-- Use the modals below to showcase details about your portfolio projects! -->

    <!-- jQuery -->
    <script src="/vue/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/vue/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="/vue/js/jqBootstrapValidation.js"></script>
    <script src="/vue/js/contact_me.js"></script>

    <!-- Theme JavaScript -->
    <script src="/vue/js/agency.min.js"></script>

</body>

</html>
`
