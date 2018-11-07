// ready :: fn -> fn
function ready(fn) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

// addClass :: String -> DOMElement -> DOMElement* (mutated)
function addClass(className, element)  {
	element.classList.add(className)
	return element
}

// removeClass :: String -> DOMElement -> DOMElement* (mutated)
function removeClass(className, element)  {
	console.log(element, element.classList)
	element.classList.remove(className)
	return element
}

// hasClass :: String -> DOMElement -> Boolean
function hasClass(className, element) {
	return element && element.classList.contains(className)
}

//	toggleClass :: String -> DOMElement -> DOMElement* (mutated)
function toggleClass(className, element) {
	return hasClass(className, element)
		? removeClass(className, element)
		: addClass(className, element)
}

/**
 * # Scroll header
 * The header has no coloured background by default. As you scroll, we want to add one so you can read the links further down the page.
 */
function check_scroll_header() {
	var htmlElement = document.querySelector('html')
	var top = window.pageYOffset || document.documentElement.scrollTop;

	if (top > (window.innerHeight * .1)) {
		addClass('fill', htmlElement);
	} else {
		removeClass('fill', htmlElement);
	}
}


ready(function () {
	// run on page load
	check_scroll_header();
	document.getElementById('menu-trigger').addEventListener('click', function (e) {
		var htmlElement = document.querySelector('html')
		toggleClass('show-nav', htmlElement)
	});
})
//

// run on scroll
window.addEventListener('scroll', check_scroll_header);
