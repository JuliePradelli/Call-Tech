<?php
include('header.php');
?>
    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Authorisation de création de conférence</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form name="sentMessage" id="contactForm" novalidate>
                        <div class="row">
                            <div class="col-md-offset-3 col-md-6">  
                                <br/>
                                <div class="col-lg-12 text-center">
                                <h2>Tableau Utilisateurs</h2>           
                                  <table class="table table-bordered">
                                    <thead>
                                      <tr>
                                        <th>Nom</th>
                                        <th>Mobile</th>
                                        <th>Email</th>
                                        <th>Authorisation</td>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <tr>
                                        <td>Henry</td>
                                        <td>0648523695</td>
                                        <td>Henry@hotmail.fr</td>
                                        <td><input type="checkbox"></td>
                                      </tr>
                                      <tr>
                                        <td>Camille</td>
                                        <td>0625367545</td>
                                        <td>Cam0@gmail.com</td>
                                        <td><input type="checkbox" value="yes"></td>
                                      </tr>
                                      <tr>
                                        <td>Verde</td>
                                        <td>0648956214</td>
                                        <td>Verdehile@yahoo.fr</td>
                                        <td><input type="checkbox" id="cbox1" value="checkbox1"></td>
                                      </tr>
                                    </tbody>
                                  </table>
                                </div>
                                <div class="dropdown">
                                    <span class="caret"></span>
                                  </button>
                                  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                    <li><a href="#">Mobile</a></li>
                                    <li><a href="#">VoiceMail</a></li>
                                  </ul>
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

<?php
include('footer.php');
?>
