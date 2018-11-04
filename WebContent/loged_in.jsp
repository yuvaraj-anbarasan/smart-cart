<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="./css/Dropdown_style.css">
		<script src="./js/jquery-3.3.1.min.js">
		</script>
		<script>
			$(document).ready(function() { 
				$('.menu').click(function(){
					$('.dropdown_menu').toggleClass('dropdown_menu--open');
					$(this).toggleClass('open');
				})
			});
		</script>
	</head>
	<body>
		<header>
			<div class="container">
				<div class="menu">
					<div class='menu_img'> </div>
				</div>
				<label>Todays Offers</label>
				<a href="cart.jsp" id="cart"><img src="./images/cart2.png" width="35px" height="25px"></a>
				<nav class="dropdown_menu">
					<ul>
						<div class="top_menu">
							<li><a href="loged_in.jsp"><img src="./images/offer.png" width="20px" height="20px"><span>Todays offers</span></a>
							</li>
							<li><a href="profile.html"><img src="./images/profile.png" width="20px" height="20px"><span>Profile details</span>
							</a></li>
							<li><a href="receipts.jsp"><img src="./images/receipts.png" width="20px" height="20px"><span>Receipts</span></a>
							</li>
							<li><a href="about.html"><img src="./images/about.png" width="20px" height="20px"><span>About</span></a>
							</li>
						</div>
						<div class="bottom_menu">
							<li><a href="contactus.html">Contact us</a></li>
							<li><a href="Logout_Controller">Logout</a></li>
						</div>
					</ul>
				</nav>
			</div>
		</header>
		
		<footer>
			
		</footer>
	</body>
</html>