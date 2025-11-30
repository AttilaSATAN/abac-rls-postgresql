-- CreateEnum
CREATE TYPE "Classification" AS ENUM ('PUBLIC', 'INTERNAL', 'CONFIDENTIAL');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAttributes" (
    "userId" INTEGER NOT NULL,
    "attributeKey" VARCHAR(100) NOT NULL,
    "attributeValue" TEXT NOT NULL,

    CONSTRAINT "UserAttributes_pkey" PRIMARY KEY ("userId","attributeKey")
);

-- CreateTable
CREATE TABLE "Document" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT,
    "ownerId" INTEGER,
    "department" VARCHAR(100),
    "classification" "Classification",
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Document_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE INDEX "UserAttributes_userId_attributeKey_idx" ON "UserAttributes"("userId", "attributeKey");

-- AddForeignKey
ALTER TABLE "UserAttributes" ADD CONSTRAINT "UserAttributes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Document" ADD CONSTRAINT "Document_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
