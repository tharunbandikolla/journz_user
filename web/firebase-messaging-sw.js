importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");


firebase.initializeApp({
    apiKey: "AIzaSyDGMeIC3w91gTQgAYYo_W0fmrweyFEqhO0",
    authDomain: "journzsocialnetwork.firebaseapp.com",
    projectId: "journzsocialnetwork",
    storageBucket: "journzsocialnetwork.appspot.com",
    messagingSenderId: "363234200077",
    appId: "1:363234200077:web:4ae5d2efeaf32911e4e344"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();



// Optional:
messaging.onBackgroundMessage((m) => {
  
  /* 

  console.log("onBackgroundMessage", m);
  console.log(m["data"]["webUrl"]);
  const notificationTitle = m["data"]["message"];
  const notificationOptions = {
    body: m["data"]["sendername"],
    icon: 'assets/images/journzpng2.png'
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions); */

  
});