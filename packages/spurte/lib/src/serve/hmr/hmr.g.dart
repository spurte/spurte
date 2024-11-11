// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hmr.dart';

// **************************************************************************
// StrEmbeddingGenerator
// **************************************************************************

const _$hmr_client_script = r'''
/**
 * @file hmr_client.js
 * @copyright The Spurte Authors
 * 
 * The Spurte HMR Client Module
 * This file is used for working with HMR on the client
 * 
 * In the future this will be written in TypeScript alongside all other JS-Related parts of Spurte
 */

// Instantiate HMR
const HMREvent = new CustomEvent('hmr');

const socket = new WebSocket(`${window.location.origin.replace("http", "ws")}/spurte__ws`);

socket.addEventListener('open', (ev) => {
    console.log('Connected to WebSocket Server for HMR');
});

socket.addEventListener('message', (ev) => {
    if (ev.data == 'refresh') {
        console.log('Refreshing...');
        window.location.reload();
    }
});

socket.addEventListener("close", () => {
    console.log("Connection lost - Reconnecting...");

    let reconnectionTimerId = setTimeout(() => {
        // Try to connect again, and if successful
        // trigger a browser refresh.
        connect(refresh);
    }, 1000);

    clearTimeout(reconnectionTimerId);

});
''';
