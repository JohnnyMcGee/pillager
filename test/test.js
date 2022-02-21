const assert = require("assert");
const {
  initializeTestEnvironment,
  assertSucceeds,
  assertFails,
} = require("@firebase/rules-unit-testing");
const { it } = require("mocha");
const fs = require("fs");

MY_PROJECT_ID = "social-rules";
const myId = "user_abc";
const theirId = "user_xyz";
const myAuth = { uid: myId, email: "abc@gmail.com" };

const getTestEnv = async () => {
  return await initializeTestEnvironment({
    projectId: MY_PROJECT_ID,
    firestore: {
      //   rules: fs.readFileSync("firestore.rules", "utf8"),
      host: "localhost",
      port: 8080,
    },
  });
};

describe("Pillager Firestore Rules", () => {
  before(async () => {
    testEnv = await getTestEnv();
  });
  afterEach(async () => {
    await testEnv.clearFirestore();
  });
  it("can load authenticated context", async () => {
    const firestore = testEnv.authenticatedContext(myId).firestore();
    assert(typeof firestore === "object");
  });
  it("can load unauthenticated context", async () => {
    const firestore = testEnv.unauthenticatedContext(myId).firestore();
    assert(typeof firestore === "object");
  });
  it("Cannot read raids collection if unauthenticated", async () => {
    const db = testEnv.unauthenticatedContext().firestore();
    const testDoc = db.collection("raids").doc("testDoc");
    await assertFails(testDoc.get());
  });
  it("Can read raids collection if authenticated", async () => {
    const db = testEnv.authenticatedContext(myId).firestore();
    const testDoc = db.collection("raids").doc("testDoc");
    await assertSucceeds(testDoc.get());
  });
  after(async () => {
    await testEnv.cleanup();
  });
});

//   it("Can't write raids collection if not authenticated", async () => {
//     const db = getFirestore(null);
//     const testDoc = db.collection("raids").doc("testDoc1");
//     await firebase.assertFails(testDoc.set({ data: "someData" }));
//   });

//   it("Can write raids collection if authenticated", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("raids").doc("testDoc1");
//     await firebase.assertSucceeds(testDoc.set({ data: "someData" }));
//   });

//   it("Cannot read vikings collection if not authenticated", async () => {
//     const db = getFirestore(null);
//     const testDoc = db.collection("vikings").doc("vikingDoc");
//     await firebase.assertFails(testDoc.get());
//   });

//   it("Can read vikings collection if not authenticated", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("vikings").doc("vikingDoc");
//     await firebase.assertSucceeds(testDoc.get());
//   });

//   it("Cannot write to viking doc if not authenticated as that user", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("vikings").doc(theirId);
//     await firebase.assertFails(testDoc.set({ data: "some_data" }));
//   });

//   it("Can write to viking doc if authenticated as that user", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("vikings").doc(myId);
//     await firebase.assertSucceeds(testDoc.set({ data: "some_data" }));
//   });

//   it("Cannot read comments collection if not authenticated", async () => {
//     const db = getFirestore(null);
//     const testDoc = db.collection("comments").doc("commentId");
//     await firebase.assertFails(testDoc.get());
//   });

//   it("Can read comments collection if authenticated", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("comments").doc("commentId");
//     await firebase.assertSucceeds(testDoc.get());
//   });

//   it("Cannot create comment if user is not the sender", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("comments").doc("commentABC");
//     await firebase.assertFails(testDoc.set(theirComment));
//   });

//   it("Can create comment if user is the sender", async () => {
//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("comments").doc("commentDEF");
//     await firebase.assertSucceeds(testDoc.set(myComment));
//   });

//   it("Cannot update comment if user is not the sender", async () => {
//     const admin = getAdminFirestore();
//     const commentId = "commentABC";
//     const setupDoc = admin.collection("comments").doc(commentId);
//     await setupDoc.set(theirComment);

//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("comments").doc(commentId);
//     await firebase.assertFails(testDoc.update({ message: "new message" }));
//   });

//   it("Can update comment if user is the sender", async () => {
//     const admin = getAdminFirestore();
//     const commentId = "commentGHI";
//     const setupDoc = admin.collection("comments").doc(commentId);
//     await setupDoc.set(myComment);

//     const db = getFirestore(myAuth);
//     const testDoc = db.collection("comments").doc(commentId);
//     await firebase.assertSucceeds(
//       testDoc.set({ sender: myId, message: "another message" })
//     );
//   });
