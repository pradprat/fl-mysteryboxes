const appId = 'PpFKYr08Bs3Jt3uJ2DSgl7bzgyZLwDloijGWu2yO';
const serverUrl = 'https://9emw51mxgeqk.usemoralis.com:2053/server';

const MYSTERY_BOX_CONTRACT = '0x673B239a310578a74D3D00cbd1dB75AA9751E901';
const ERC20_CONTRACT = '0x0dA754900dF8634e83C4c993e5CF28D0B15aff9c'; //CK
// const ERC20_CONTRACT = '0xf10499b90bcC14ebA723C7Dabe51bfaE9fB0B681'; //CPK
const NETWORK = 'bsc';

Moralis.start({ serverUrl, appId });

let currentUserSession;

init = async () => {
    $('#inventoryBtn').hide();
    currentUserSession = await Moralis.User.current();
    if (currentUserSession) {
        $('#inventoryBtn').show();
        console.log(currentUserSession);
        $('#connect').html(
            `
      <span class="btn-text">${currentUserSession.attributes.ethAddress}</span>
                        <i class="fas fa-sign-out-alt"></i>
      `,
        );
        $('#connect').attr(`onclick`, `logout();`);

        await Moralis.enableWeb3();
    }
};

login = async () => {
    if (!currentUserSession) {
        currentUserSession = await Moralis.authenticate({
            signingMessage: 'Connect to CryptoKillers',
        });
        console.log(currentUserSession);
        window.location.reload();
    }
    $('#' + target).html(`<div class="spinner-border" role="status"></div>`);
};

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

fetchInventory = async () => {
    currentUserSession = await Moralis.User.current();

    const options = {
        chain: NETWORK,
        address: currentUserSession.attributes.ethAddress,
        // address: "0xa37EB6E5a3A665C721D879e19EE3B9c34d21cF65",
        token_address: MYSTERY_BOX_CONTRACT,
    };
    const NFTs = await Moralis.Web3API.account.getNFTsForContract(options);
    console.log(NFTs);
    NFTs.result.forEach(nft => {
        console.log(nft);
        $.getJSON(nft.token_uri, function (data) {
            console.log(data);
            $('#inventoryBox').append(`
             <div class="cnt-box">
                 <img src="${data.image}" alt="mercenarie">
                 <span class="bx-name text-white">Mercenary</span>
                 <span class="bx-rarity text-white">${data.rarity}</span>
             </div>
             `);
        });
    });

    const BscNFTOwners = Moralis.Object.extend('BscNFTOwners');
    const query = new Moralis.Query(BscNFTOwners);
    query.equalTo('owner_of', currentUserSession.attributes.ethAddress);
    query.equalTo('token_address', MYSTERY_BOX_CONTRACT.toLowerCase());
    const results = await query.find();
    results.forEach(result => {
        console.log(result);
        $.getJSON(result.attributes.token_uri, function (data) {
            $('#inventoryBox').append(`
            <div class="cnt-box">
                <img src="${data.image}" alt="mercenarie">
                <span class="bx-name text-white">Mercenary</span>
                <span class="bx-rarity text-white">${data.rarity}</span>
            </div>
        `);
            console.log(data);
        });
    });

    const BscNFTOwnersPending = Moralis.Object.extend('BscNFTOwnersPending');
    const query2 = new Moralis.Query(BscNFTOwnersPending);
    query2.equalTo('owner_of', currentUserSession.attributes.ethAddress);
    query2.equalTo('token_address', MYSTERY_BOX_CONTRACT.toLowerCase());
    const results2 = await query2.find();
    results2.forEach(result => {
        console.log(result);
        $.getJSON(result.attributes.token_uri, function (data) {
            $('#inventoryBox').append(`
            <div class="cnt-box">
                <img src="${data.image}" alt="mercenarie">
                <span class="bx-name text-white">Mercenary</span>
                <span class="bx-rarity text-white">${data.rarity}</span>
            </div>
        `);
            console.log(data);
        });
    });

    //   $("#itemCount").text(invCount);
};
openStandardBNB = async () => {
    if (currentUserSession) {
        try {
            const options = {
                contractAddress: MYSTERY_BOX_CONTRACT,
                functionName: 'openStandardBox',
                abi: mysteryAbi,
                msgValue: Moralis.Units.ETH('0.11'),
            };
            await Moralis.executeFunction(options);
            showOpenCrateAnimation('standard');

            // await Swal.fire(
            //     'Mystery Box unlock successful! Please check inventory in following minutes in order to see what you have won!',
            //     '',
            //     'success',
            // );
            // window.location.reload();
        } catch (e) {
            Swal.fire('An error occured', '', 'error');
        }
    } else Swal.fire('Please login in order to unlock a box', '', 'error');
};

openStandardCPK = async () => {
    if (currentUserSession) {
        try {
            await Moralis.executeFunction({
                contractAddress: ERC20_CONTRACT,
                functionName: 'approve',
                abi: erc20Abi,
                params: {
                    _spender: MYSTERY_BOX_CONTRACT,
                    _value: Moralis.Units.ETH('650'),
                },
            });

            const options = {
                contractAddress: MYSTERY_BOX_CONTRACT,
                functionName: 'openStandardBoxCPK',
                abi: mysteryAbi,
            };
            const result = await Moralis.executeFunction(options);
            console.log(result);
            showOpenCrateAnimation('standard');
            // await Swal.fire(
            //     'Mystery Box unlock successful! Please check inventory in following minutes in order to see what you have won!',
            //     '',
            //     'success',
            // );
            // window.location.reload();
        } catch (e) {
            console.log(e);
            Swal.fire('An error occured', '', 'error');
        }
    } else Swal.fire('Please login in order to unlock a box', '', 'error');
};

openDeluxeBNB = async () => {
    if (currentUserSession) {
        try {
            const options = {
                contractAddress: MYSTERY_BOX_CONTRACT,
                functionName: 'openDeluxeBox',
                abi: mysteryAbi,
                msgValue: Moralis.Units.ETH('0.21'),
            };
            await Moralis.executeFunction(options);
            showOpenCrateAnimation('deluxe');

            // await Swal.fire(
            //     'Mystery Box unlock successful! Please check inventory in following minutes in order to see what you have won!',
            //     '',
            //     'success',
            // );
            // window.location.reload();
        } catch (e) {
            Swal.fire('An error occured', '', 'error');
        }
    } else Swal.fire('Please login in order to unlock a box', '', 'error');
};

openDeluxeCPK = async () => {
    if (currentUserSession) {
        try {
            await Moralis.executeFunction({
                contractAddress: ERC20_CONTRACT,
                functionName: 'approve',
                abi: erc20Abi,
                params: {
                    _spender: MYSTERY_BOX_CONTRACT,
                    _value: Moralis.Units.ETH('1200'),
                },
            });

            const options = {
                contractAddress: MYSTERY_BOX_CONTRACT,
                functionName: 'openDeluxeBoxCPK',
                abi: mysteryAbi,
            };
            await Moralis.executeFunction(options);
            showOpenCrateAnimation('deluxe');

            // await Swal.fire(
            //     'Mystery Box unlock successful! Please check inventory in following minutes in order to see what you have won!',
            //     '',
            //     'success',
            // );
            // window.location.reload();
        } catch (e) {
            Swal.fire('An error occured', '', 'error');
        }
    } else Swal.fire('Please login in order to unlock a box', '', 'error');
};

openUltimateBNB = async () => {
    if (currentUserSession) {
        try {
            const options = {
                contractAddress: MYSTERY_BOX_CONTRACT,
                functionName: 'openUltimateBox',
                abi: mysteryAbi,
                msgValue: Moralis.Units.ETH('0.53'),
            };
            await Moralis.executeFunction(options);
            showOpenCrateAnimation('ultimate');

            // await Swal.fire(
            //     'Mystery Box unlock successful! Please check inventory in following minutes in order to see what you have won!',
            //     '',
            //     'success',
            // );
            // window.location.reload();
        } catch (e) {
            Swal.fire('An error occured', '', 'error');
        }
    } else Swal.fire('Please login in order to unlock a box', '', 'error');
};

openUltimateCPK = async () => {
    if (currentUserSession) {
        try {
            await Moralis.executeFunction({
                contractAddress: ERC20_CONTRACT,
                functionName: 'approve',
                abi: erc20Abi,
                params: {
                    _spender: MYSTERY_BOX_CONTRACT,
                    _value: Moralis.Units.ETH('3000'),
                },
            });

            const options = {
                contractAddress: MYSTERY_BOX_CONTRACT,
                functionName: 'openUltimateBoxCPK',
                abi: mysteryAbi,
            };
            await Moralis.executeFunction(options);
            showOpenCrateAnimation('ultimate');
            // await Swal.fire(
            //     'Mystery Box unlock successful! Please check inventory in following minutes in order to see what you have won!',
            //     '',
            //     'success',
            // );
            // window.location.reload();
        } catch (e) {
            Swal.fire('An error occured', '', 'error');
        }
    } else Swal.fire('Please login in order to unlock a box', '', 'error');
};

showOpenCrateAnimation = async type => {
    const options = {
        chain: NETWORK,
        address: currentUserSession.attributes.ethAddress,
        token_address: MYSTERY_BOX_CONTRACT,
    };
    const NFTs = await Moralis.Web3API.account.getNFTsForContract(options);
    const nft = NFTs.result[NFTs.result.length - 1];
    console.log(nft);
    $.getJSON(nft.token_uri, function (data) {
        console.log(data);
        $('#crate-modal')[0].innerHTML = `
                <video id="crate-video" src="./assets/videos/${type}.webm" controls playsinline uk-video
                        class="bg-transparent video-open-crate"></video>
                `;
        UIkit.modal('#crate-modal-sections').show();
        $('#crate-video')[0].addEventListener('ended', myHandler, false);
        function myHandler(e) {
            $('#crate-modal')[0].innerHTML = `
                <img src=${data.image} alt="" srcset="" class="video-open-crate">
                `;
            console.log('finish');
        }
    });
};

logout = async () => {
    await Moralis.User.logOut();
    window.location.reload();
};

$(document).ready(function () {
    init();
});
