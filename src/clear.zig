const std = @import("std");
const Io = std.Io;

const esc = "\x1B";
const csi = esc ++ "[";

pub fn clearCurrentLine(writer: *Io.Writer) !void {
    try writer.writeAll(csi ++ "2K");
}

pub fn clearFromCursorToLineBeginning(writer: *Io.Writer) !void {
    try writer.writeAll(csi ++ "1K");
}

pub fn clearFromCursorToLineEnd(writer: *Io.Writer) !void {
    try writer.writeAll(csi ++ "K");
}

pub fn clearScreen(writer: *Io.Writer) !void {
    try writer.writeAll(csi ++ "2J");
}

pub fn clearFromCursorToScreenBeginning(writer: *Io.Writer) !void {
    try writer.writeAll(csi ++ "1J");
}

pub fn clearFromCursorToScreenEnd(writer: *Io.Writer) !void {
    try writer.writeAll(csi ++ "J");
}
