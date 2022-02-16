const assert = require("assert");
const firebase = require("@firebase/testing");

const MY_PROJECT_ID = "pillager-af9ef";
const myId = "user_abc";
const theirId = "user_xyz";
const myAuth = { uid: myId, email: "abc@vikings.vik" };
const myComment = { sender: myId, message: "Cowabunga, dude!" };
const theirComment = { uid: theirId, message: "It's Pizza Time!" };

function getFirestore(auth) {
  return firebase
    .initializeTestApp({ projectId: MY_PROJECT_ID, auth: auth })
    .firestore();
}

function getAdminFirestore() {
  return firebase.initializeAdminApp({ projectId: MY_PROJECT_ID }).firestore();
}

describe("Pillager app", () => {
  beforeEach(async () => {
    await firebase.clearFirestoreData({ projectId: MY_PROJECT_ID });
  });

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
    const testDoc = db.collection("raids").doc("testDoc1");
    await firebase.assertFails(testDoc.set({ data: "someData" }));
  });

  it("Can write raids collection if authenticated", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("raids").doc("testDoc1");
    await firebase.assertFails(testDoc.set({ data: "someData" }));
  });

  it("Cannot read vikings collection if not authenticated", async () => {
    const db = getFirestore(null);
    const testDoc = db.collection("vikings").doc("vikingDoc");
    await firebase.assertFails(testDoc.get());
  });

  it("Can read vikings collection if not authenticated", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("vikings").doc("vikingDoc");
    await firebase.assertFails(testDoc.get());
  });

  it("Cannot write to viking doc if not authenticated as that user", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("vikings").doc(theirId);
    await firebase.assertFails(testDoc.get());
  });

  it("Can write to viking doc if authenticated as that user", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("vikings").doc(myId);
    await firebase.assertFails(testDoc.get());
  });

  it("Cannot read comments collection if not authenticated", async () => {
    const db = getFirestore(null);
    const testDoc = db.collection("comments").doc("commentId");
    await firebase.assertFails(testDoc.get());
  });

  it("Can read comments collection if authenticated", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("comments").doc("commentId");
    await firebase.assertFails(testDoc.get());
  });

  it("Cannot create comment if user is not the sender", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("comments").doc("commentABC");
    await firebase.assertFails(testDoc.set(theirComment));
  });

  it("Can create comment if user is the sender", async () => {
    const db = getFirestore(myAuth);
    const testDoc = db.collection("comments").doc("commentDEF");
    await firebase.assertFails(testDoc.set(myComment));
  });

  it("Cannot update comment if user is not the sender", async () => {
    const admin = getAdminFirestore();
    const commentId = "commentABC";
    const setupDoc = admin.collection("comments").doc(commentId);
    await setupDoc.set(theirComment);

    const db = getFirestore(myAuth);
    const testDoc = db.collection("comments").doc(commentId);
    await firebase.assertFails(testDoc.update({ message: "new message" }));
  });

  it("Can update comment if user is the sender", async () => {
    const admin = getAdminFirestore();
    const commentId = "commentGHI";
    const setupDoc = admin.collection("comments").doc(commentId);
    await setupDoc.set(myComment);

    const db = getFirestore(myAuth);
    const testDoc = db.collection("comments").doc(commentId);
    await firebase.assertSucceeds(testDoc.update({ message: "another message" }));
  });

  after(async () => {
    await firebase.clearFirestoreData({ projectId: MY_PROJECT_ID });
  });
});
