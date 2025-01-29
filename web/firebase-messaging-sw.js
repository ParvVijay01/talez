importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDe4S4QA_WQR0ZmNiAtV2HwP2eWx_4FAwU",
  authDomain: "talez-2f54d.firebaseapp.com",
  projectId: "talez-2f54d",
  storageBucket: "talez-2f54d.appspot.com",
  messagingSenderId: "227834706852",
  appId: "1:227834706852:web:04f3afb45770938b2a1f31",
  measurementId: "G-9SLY4TWHCK"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});