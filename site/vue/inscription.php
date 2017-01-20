<?php
    include('header.php');
    ?>
<link href="../css/jquery.multiselect.css" rel="stylesheet" type="text/css">
<script src="../js/jquery.multiselect.js"></script>
    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <form action="" name="sentMessage" id="contactForm" novalidate>
                        <div class="row">
                            <div class="col-lg-6">  
                                <h3 class="section-heading">inscription nouvel utilisateur</h3>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Login</span>
                                      <input type="text" class="form-control" placeholder="Login" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Mot de passe</span>
                                      <input type="password" class="form-control" placeholder="Mot de passe" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Vérification mot de passe</span>
                                      <input type="password" class="form-control" placeholder="Mot de passe" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">email</span>
                                      <input type="text" class="form-control" placeholder="email" aria-describedby="basic-addon1">
                                    </div>
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">numéro de téléphone (si fournit)</span>
                                      <input type="tel" class="form-control" placeholder="tel" aria-describedby="basic-addon1">
                                    </div>
                                    <br>
                        <button type="submit" class="btn btn-success">Ajouter <span class="glyphicon-plus"></span> </button>
                    </form>
                                <br/>
                                <br/>
                                <br/>
                            </div>
                            <div class="col-lg-6">
                         <h3 class="section-heading">Création de Contexte</h3>
                                <form name="contexte" action="">
                                <br/>
                                    <div class="input-group">
                                      <span class="input-group-addon" id="basic-addon1">Nom</span>
                                      <input type="text" class="form-control" placeholder="Nom du Contexte" aria-describedby="basic-addon1">
                                    </div>

                                    <br/>
                                    <br/>
                                    <h4 class="section-heading">Inclusion de Contexte</h4>

                                        <div class="form-group">
                                            <select name="contOpt[]" multiple="multiple" id="contOpt">
                                                <option value="somecontext">Somecontext</option>
                                                <option value="01XX">01XX</option>
                                                <option value="default">Default</option>
                                            </select>
                                            <label class="radio-inline"><input type="radio" checked name="optradio">Unidirectionnel</label>
                                            <label class="radio-inline"><input type="radio" name="optradio">Bidirectionnel</label>
                                            <br>
                                            <br>
                                            <button type="submit" class="btn btn-success">Ajouter <span class="glyphicon-plus"></span> </button>
                                        </div>
                                    </form>
                            </div>
            </div>

                </div>
            </div>
        </div>
    </section>
<script type="application/javascript">
    $('#contOpt').multiselect({
        columns: 1,
        placeholder: 'Selectionnez contexte',
        search: true
    });
</script>

<?php include('footer.php');
?>
