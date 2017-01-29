<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Création comptes utilisateurs</title>

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
                        <a class="page-scroll" href="index.php?page=accueil">Accueil</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=user_messages_vocaux">Messages vocaux</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=user_plan_appel">Plan d'appel</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=user_gestion_conference">Conférences</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="index.php?page=creation_gestion_contexte">Contexte</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <section id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Option des conférences</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form name="sentMessage" id="contactForm" novalidate>
                        <div class="row">
                            <div class="col-md-offset-3 col-md-6">  
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Utilisateur associé</span>
                                      <input type="text" class="form-control" placeholder="Utilisateur associé" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                <div class="dropdown">
                                  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                    Utilisation pour
                                    <span class="caret"></span>
                                  </button>
                                  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                    <li><a href="#">Mise en oeuvre</a></li>
                                    <li><a href="#">Suppression</a></li>
                                  </ul>
                                </div>
                                <br/>
                                  </button>
                            <div class="row">
                                <div class="row">
                                  <div class="col-lg-6">
                                    <div class="input-group">
                                        <span class="input-group-addon beautiful">
                                        <input type="checkbox">
                                        </span>
                                        <input type="text" class="form-control" placeholder="Musique de fond">
                                    </div>
                                </div>
                                <br/>
                                <br/>
                                <div class="col-lg-6">
                                    <div class="input-group">
                                        <span class="input-group-addon beautiful">
                                        <input type="checkbox">
                                        </span>
                                        <input type="text" class="form-control" placeholder="start mute sound">
                                    </div>
                                </div>
                                <br/>
                                <br/>
                                <div class="col-lg-6">
                                    <div class="input-group">
                                        <span class="input-group-addon beautiful">
                                        <input type="checkbox">
                                        </span>
                                        <input type="text" class="form-control" placeholder="Nombre de participant">
                                    </div>
                                </div>
                                <br/>
                                <br/>
                                <div class="col-lg-6">
                                    <div class="input-group">
                                        <span class="input-group-addon beautiful">
                                        <input type="checkbox">
                                        </span>
                                        <input type="text" class="form-control" placeholder="Annoncer si on est seul">
                                    </div>
                                </div>
                                <br/>
                                <br/>
                                <div class="col-lg-6">
                                    <div class="input-group">
                                        <span class="input-group-addon beautiful">
                                        <input type="checkbox">
                                        </span>
                                        <input type="text" class="form-control" placeholder="Réduction son ambiant">
                                    </div>
                                </div>
                                <br/>
                                <br/>
                                <div class="col-lg-6">
                                    <div class="input-group">
                                        <span class="input-group-addon beautiful">
                                        <input type="checkbox">
                                        </span>
                                        <input type="text" class="form-control" placeholder="Annonce entrée et sortie">
                                    </div>
                                </div>
                                <br/>
                                <br/>
                                </div>
                            </div>
                        </div>
                                <br/>
                            </div>
                            <div class="clearfix"></div>
                            <br/>
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
                    <span class="copyright">Copyright &copy; Call'Tech 2016</span>
                </div>
                <div class="col-md-4">
                   <ul class="list-inline social-buttons">
                        <li><a href="https://twitter.com/intechinfo?lang=fr"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="https://www.facebook.com/intechinfo/?ref=ts&fref=ts"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="https://www.intechinfo.fr/"><i class="fa fa-linkedin"></i></a>
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
