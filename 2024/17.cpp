#include <iostream>
#include <vector>
#include <functional>

using namespace std;

vector<int> run(const array<int, 4>& creg, const vector<int>& prog) {
    array<int, 4> reg = creg;
    vector<int> out;
    int ip = 0;

    #define opr(op) (op < 4 ? op : reg[op - 4])
    
    array<function<void(int)>, 8> ops = {
        [&](int op) { reg[0] >>= opr(op); },
        [&](int op) { reg[1] ^= op; },
        [&](int op) { reg[1] = opr(op) & 7; },
        [&](int op) { if (reg[0] > 0) ip = op - 2; },
        [&](int op) { reg[1] ^= reg[2]; },
        [&](int op) { out.push_back(opr(op) & 7); },
        [&](int op) { reg[1] = reg[0] >> opr(op); },
        [&](int op) { reg[2] = reg[0] >> opr(op); }
    };

    while (ip < prog.size()) {
        int op = prog[ip];
        int co = prog[ip + 1];
        ops[op](co);
        ip += 2;
    }

    return out;
}

// Merge logic for triplets
vector<vector<array<int, 4>>> merge(array<int, 4> f, vector<vector<array<int, 4>>> opts, int i) {
    if (i < 0) return {{}};
    vector<vector<array<int, 4>>> result;
    for (const auto& l : opts[i]) {
        if (l[1] != f[0] || l[2] != f[1] || l[3] != f[2]) continue;
        auto merged = merge(l, opts, i - 1);
        for (auto& res : merged) res.push_back(l);
        result.insert(result.end(), merged.begin(), merged.end());
    }
    return result;
};

int main() {
    // Example input; replace with actual input logic if needed
    array<int, 4> reg;
    vector<int> prog;

    // Parse the input into reg and prog arrays (assumed to be read from file or other source)
    // For simplicity, we will just hard-code a dummy example here
    reg = {63281501, 0, 0}; // Example register state
    prog = {2,4,1,5,7,5,4,5,0,3,1,6,5,5,3,0}; // Example program

    // Part 1
    vector<int> result = run(reg, prog);
    cout << "Part 1: ";
    for (size_t i = 0; i < result.size(); ++i) {
        if (i) cout << ",";
        cout << result[i];
    }
    cout << endl;

    // Part 2 - Triplets and merge logic
    array<vector<array<int, 4>>, 8> triplets;
    for (int a = 0; a < 8 * 8 * 8 * 8; ++a) {
        vector<int> pi = run({a, 0, 0}, prog);
        triplets[pi[0]].push_back({a % 8, a / 8 % 8, a / 64 % 8, a / 512});
    }

    vector<vector<array<int, 4>>> opts(prog.size());
    for (size_t i = 0; i < prog.size(); ++i) {
        opts[i] = triplets[prog[i]];
    }

    vector<vector<array<int, 4>>> sols = merge({}, opts, opts.size() - 1);

    // Part 2 - Find the minimum value
    uint64_t part2 = -1;
    for (const auto& sol : sols){
        uint64_t value = 0, f_oct = 1;
        for (const auto& digs : sol) {
            value += digs[0] * f_oct;
            f_oct *= 8;
        }
        part2 = min(part2, value);
    }

    cout << "Part 2: " << part2 << endl;

    return 0;
}
