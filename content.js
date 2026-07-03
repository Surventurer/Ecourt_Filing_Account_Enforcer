function setEmail() {
    const userName = document.querySelector('input[type="user_name"], input[name="user_name"]');
    if (userName) {
        userName.value = "9431021093";

        userName.dispatchEvent(new Event("input", { bubbles: true }));
        userName.dispatchEvent(new Event("change", { bubbles: true }));
    }
}

setEmail();

new MutationObserver(setEmail).observe(document.body, {
    childList: true,
    subtree: true
});