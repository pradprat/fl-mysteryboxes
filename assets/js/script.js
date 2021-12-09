// let serverUrl = 'https://r9od717siyit.usemoralis.com:2053/server';
// let appId = 'aYT7cry6UNFqzVL3Ps4E7h3U5ZpLfw2gNNJIvw9Y';

// Moralis.start({ serverUrl, appId });

// async function login() {
//     let user = Moralis.User.current();
//     if (!user) {
//         user = await Moralis.authenticate();
//     }
//     console.log("logged in user:", user);
// }

// document.getElementById("btn-login").onclick = login;

// // $(document).ready(function(){
// //     let hasMetaMask
// //     function getMetaMask() {
// //         if (typeof window.ethereum !== 'undefined') {
// //             hasMetaMask = true
// //             $('#btn-login').css('display','grid')
// //         } else {
// //             $('#btn-install').css('display','grid')
// //             hasMetaMask = false
// //         };
// //     }

// //     $(document).on('click','#btn-login',function(){
// //         if (getMetaMask()){
            
// //         }
// //     })
    
// //     $(document).on('click','#btn-install',async function(){
// //         if (!getMetaMask()){
// //             var win = window.open('https://metamask.io/','_blank');
// //             win.focus();
// //         }
// //     })

// //     getMetaMask();
// // });