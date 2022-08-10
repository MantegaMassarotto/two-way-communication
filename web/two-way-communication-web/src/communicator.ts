
type Topic = 'onBackPress' | 'onLogin';

/**
 * @param topic onBackPress, onLogin or onAcceptConsents.
 * @param data JSON string that will be sent back to the app.
 */

export const notifyApp = (osType: string, topic: Topic, data?: string): Promise<void> => {
  return new Promise((resolve, reject) => {
    switch (osType) {
      case 'android':
        if (Android === undefined) {
          reject('The `Android` object is missing');
          return;
        }

        Android.sendMessage(JSON.stringify({ topic, data }));
        resolve();
        break;
      case 'ios':
        if (window.webkit === undefined) {
          reject('The window object is missing the `webkit` property');
          return;
        }

        window.webkit.messageHandlers.sendMessage.postMessage(JSON.stringify({ topic, data }));
        resolve();
        break;
      default:
        reject('The osType is not set properly');
    }
  });
};
