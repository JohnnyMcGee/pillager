const assert = require("assert");
const firebase = require("@firebase/testing");

const MY_PROJECT_ID = "pillager-af9ef";
const myAuth = { uid: "user_abc", email: "abc@vikings.vik" };

function getFirestore(auth) {
  return firebase
    .initializeTestApp({ projectId: MY_PROJECT_ID, auth: auth })
    .firestore();
}

describe("Pillager app", () => {
  it("Cannot read raids collection if not authenticated", async () => {
    const db = getFirestore(null);
    const testDoc = db.collection("raids").doc("testDoc");
    await firebase.assertFails(testDoc.get());
  });

  it("Can read raids collection if authenticated", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("raids").doc("testDoc");
    await firebase.assertFails(testDoc.get());
  });

  it("Can't write raids collection if not authenticated", async () => {
    const db = getFirestore(null);
    const testDoc = db.collection("raids").doc("testDoc");
    await firebase.assertFails(testDoc.set({data: "someData"}));
  });
});
