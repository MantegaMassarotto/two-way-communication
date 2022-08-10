interface Window {
  // This is created when the site is loaded by the iOS app in our code
  webkit?: {
    messageHandlers: {
      sendMessage: {
        postMessage: (d: string) => any;
      };
    };
  };
}

declare let Android:
  | {
      sendMessage: (d: string) => any;
    }
  | undefined;
