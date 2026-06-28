const std = @import("std");
const testing = std.testing;
const Io = std.Io;
const esc = "\x1B";
const csi = esc ++ "[";

pub const CursorMode = enum(u8) {
    blinking_block = 1,
    block,
    blinking_underscore,
    underscore,
    blinking_I_beam,
    I_beam,
};

pub fn setCursorMode(writer: *Io.Writer, mode: CursorMode) Io.Writer.Error!void {
    const modeNumber = @intFromEnum(mode);
    try writer.print(csi ++ "{d} q", .{modeNumber});
}

pub fn hideCursor(writer: *Io.Writer) Io.Writer.Error!void {
    try writer.writeAll(csi ++ "?25l");
}

pub fn showCursor(writer: *Io.Writer) Io.Writer.Error!void {
    try writer.writeAll(csi ++ "?25h");
}

pub fn saveCursor(writer: *Io.Writer) Io.Writer.Error!void {
    try writer.writeAll(csi ++ "s");
}

pub fn restoreCursor(writer: *Io.Writer) Io.Writer.Error!void {
    try writer.writeAll(csi ++ "u");
}

pub fn setCursor(writer: *Io.Writer, x: usize, y: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{};{}H", .{ y + 1, x + 1 });
}

pub fn setCursorRow(writer: *Io.Writer, row: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}H", .{row + 1});
}

pub fn setCursorColumn(writer: *Io.Writer, column: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}G", .{column + 1});
}

pub fn cursorUp(writer: *Io.Writer, lines: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}A", .{lines});
}

pub fn cursorDown(writer: *Io.Writer, lines: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}B", .{lines});
}

pub fn cursorForward(writer: *Io.Writer, columns: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}C", .{columns});
}

pub fn cursorBackward(writer: *Io.Writer, columns: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}D", .{columns});
}

pub fn cursorNextLine(writer: *Io.Writer, lines: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}E", .{lines});
}

pub fn cursorPreviousLine(writer: *Io.Writer, lines: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}F", .{lines});
}

pub fn scrollUp(writer: *Io.Writer, lines: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}S", .{lines});
}

pub fn scrollDown(writer: *Io.Writer, lines: usize) Io.Writer.Error!void {
    try writer.print(csi ++ "{}T", .{lines});
}

test "test cursor mode BLINKING_UNDERSCORE" {
    var buf: [1024]u8 = undefined;
    var fixed_writer: Io.Writer = .fixed(&buf);

    try setCursorMode(&fixed_writer, .blinking_underscore);
    // the space is needed
    const expected = csi ++ "3 q";
    const actual = fixed_writer.buffered();

    try testing.expectEqualSlices(u8, expected, actual);
}

test "test cursor mode BLINKING_I_BEAM" {
    var buf: [1024]u8 = undefined;
    var fixed_writer: Io.Writer = .fixed(&buf);

    try setCursorMode(&fixed_writer, .blinking_I_beam);
    // the space is needed
    const expected = csi ++ "5 q";
    const actual = fixed_writer.buffered();

    try testing.expectEqualSlices(u8, expected, actual);
}
