const assert = require("assert");
const {
  initializeTestEnvironment,
  RulesTestEnvironment,
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

describe("Social Rules App", () => {
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
  after(async () => {
    await testEnv.cleanup();
  });

  //   beforeEach(async () => {
  //     await firebase.RulesTestEnvironment.clearFirestore({ projectId: MY_PROJECT_ID });
  //   });
  //   it("Can read items in the read-only collection", async () => {
  //     const db = getFirestore(null);
  //     const testDoc = db.collection("readonly").doc("testDoc");
  //     await firebase.assertSucceeds(testDoc.get());
  //   });
  //   it("Cannot write items in the read-only collection", async () => {
  //     const db = getFirestore(null);
  //     const anotherDoc = db.collection("readonly").doc("anotherDoc");
  //     await firebase.assertFails(anotherDoc.set({ foo: "bar" }));
  //   });
  //   it("Can write to a user document with the same ID as our user", async () => {
  //     const db = getFirestore(myAuth);
  //     const testDoc = db.collection("users").doc(myId);
  //     await firebase.assertSucceeds(testDoc.set({ foo: "bar" }));
  //   });
  //   it("Cannot write to a user document with a different ID from our user", async () => {
  //     const db = getFirestore(myAuth);
  //     const testDoc = db.collection("users").doc(theirId);
  //     await firebase.assertFails(testDoc.set({ foo: "bar" }));
  //   });
  //   it("Can read posts marked public", async () => {
  //     const db = getFirestore(null);
  //     const testQuery = db
  //       .collection("posts")
  //       .where("visibility", "==", "public");
  //     await firebase.assertSucceeds(testQuery.get());
  //   });
  //   it("Can query personal posts", async () => {
  //     const db = getFirestore(myAuth);
  //     const testQuery = db.collection("posts").where("authorId", "==", myId);
  //     await firebase.assertSucceeds(testQuery.get());
  //   });
  //   it("Can't query all posts", async () => {
  //     const db = getFirestore(myAuth);
  //     const testQuery = db.collection("posts");
  //     await firebase.assertFails(testQuery.get());
  //   });
  //   it("Can read a single public post", async () => {
  //     const admin = getAdminFirestore();
  //     const postId = "public_post";
  //     const setupDoc = admin.collection("posts").doc(postId);
  //     await setupDoc.set({ authorId: theirId, visibility: "public" });
  //     const db = getFirestore(null);
  //     const testQuery = db.collection("posts").doc(postId);
  //     await firebase.assertSucceeds(testQuery.get());
  //   });
  //   it("Can read a private post belonging to the user", async () => {
  //     const admin = getAdminFirestore();
  //     const postId = "private_post";
  //     const setupDoc = admin.collection("posts").doc(postId);
  //     await setupDoc.set({ authorId: myId, visibility: "private" });
  //     const db = getFirestore(myAuth);
  //     const testQuery = db.collection("posts").doc(postId);
  //     await firebase.assertSucceeds(testQuery.get());
  //   });
  //   it("Can't read a private post belonging to another user", async () => {
  //     const admin = getAdminFirestore();
  //     const postId = "their_private_post";
  //     const setupDoc = admin.collection("posts").doc(postId);
  //     await setupDoc.set({ authorId: theirId, visibility: "private" });
  //     const db = getFirestore(null);
  //     const testQuery = db.collection("posts").doc(postId);
  //     await firebase.assertFails(testQuery.get());
  //   });
  //   after(async () => {
  //     await firebase.RulesTestEnvironment.clearFirestore({ projectId: MY_PROJECT_ID });
  //   });
});
