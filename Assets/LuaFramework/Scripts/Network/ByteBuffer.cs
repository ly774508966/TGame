using UnityEngine;
using System.Collections;
using System.IO;
using System.Text;
using System;
using LuaInterface;

namespace LuaFramework {
    public class ByteBuffer {
        MemoryStream stream = null;
        BinaryWriter writer = null;
        BinaryReader reader = null;

        public ByteBuffer() {
            stream = new MemoryStream();
            writer = new BinaryWriter(stream);
        }

        public ByteBuffer(byte[] data) {
            if (data != null) {
                stream = new MemoryStream(data);
                reader = new BinaryReader(stream);
            } else {
                stream = new MemoryStream();
                writer = new BinaryWriter(stream);
            }
        }

        public void Close() {
            if (writer != null) writer.Close();
            if (reader != null) reader.Close();

            stream.Close();
            writer = null;
            reader = null;
            stream = null;
        }

        public void WriteByte(byte v) {
            writer.Write(v);
        }

        public void WriteInt(int v) {
            byte[] b = IntToBytes(v);
            writer.Write(IntToBytes(v));
            //writer.Write((int)v);
        }

        public void WriteShort(ushort v) {
            writer.Write((ushort)v);
        }

        public void WriteLong(long v) {
            writer.Write((long)v);
        }

        public void WriteFloat(float v) {
            byte[] temp = BitConverter.GetBytes(v);
            Array.Reverse(temp);
            writer.Write(BitConverter.ToSingle(temp, 0));
        }

        public void WriteDouble(double v) {
            byte[] temp = BitConverter.GetBytes(v);
            Array.Reverse(temp);
            writer.Write(BitConverter.ToDouble(temp, 0));
        }

        public void WriteString(string v) {
            byte[] bytes = Encoding.UTF8.GetBytes(v);
            writer.Write((ushort)bytes.Length);
            writer.Write(bytes);
        }

        public void WriteBytes(byte[] v) {
            writer.Write(v);
        }

        public void WriteBuffer(LuaByteBuffer strBuffer) {
            WriteBytes(strBuffer.buffer);
        }

        public byte ReadByte() {
            return reader.ReadByte();
        }

        public int ReadInt() {
            byte[] bytes = reader.ReadBytes(4);
            return BytesToInt(bytes,0);
            //return (int)reader.ReadInt32();
        }

        public ushort ReadShort() {
            return (ushort)reader.ReadInt16();
        }

        public long ReadLong() {
            return (long)reader.ReadInt64();
        }

        public float ReadFloat() {
            byte[] temp = BitConverter.GetBytes(reader.ReadSingle());
            Array.Reverse(temp);
            return BitConverter.ToSingle(temp, 0);
        }

        public double ReadDouble() {
            byte[] temp = BitConverter.GetBytes(reader.ReadDouble());
            Array.Reverse(temp);
            return BitConverter.ToDouble(temp, 0);
        }

        public string ReadString() {
            ushort len = ReadShort();
            byte[] buffer = new byte[len];
            buffer = reader.ReadBytes(len);
            return Encoding.UTF8.GetString(buffer);
        }

        public byte[] ReadBytes() {
            return reader.ReadBytes((int)(stream.Length - stream.Position));
        }

        public LuaByteBuffer ReadBuffer() {
            byte[] bytes = ReadBytes();
            return new LuaByteBuffer(bytes);
        }

        public byte[] ToBytes() {
            writer.Flush();
            byte[] b = stream.ToArray();
            return b;
        }

        public void Flush() {
            writer.Flush();
        }
        /// <summary]] >
        /// bytes转int
        /// </summary]] >
        /// <param name="data"]] > </param]] >
        /// <param name="offset"]] > </param]] >
        /// <returns]] > </returns]] >
        public static int BytesToInt(byte[] data, int offset)
        {
            int num = 0;
            for (int i = offset; i < offset + 4; i++)
            {
                num <<= 8;
                num |= (data[i] & 0xff);
            }
            return num;
        }

        /// <summary]] >
        /// int 转 bytes
        /// </summary]] >
        /// <param name="num"]] > </param]] >
        /// <returns]] > </returns]] >
        public static byte[] IntToBytes(int num)
        {
            byte[] bytes = new byte[4];
            for (int i = 0; i < 4; i++)
            {
                bytes[i] = (byte)(num >> (24 - i * 8));
            }
            return bytes;
        }

    }
}